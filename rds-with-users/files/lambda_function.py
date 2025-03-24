import os
import json
import boto3
import psycopg2
import pymysql
import time

def handler(event, context):
    """
    Lambda function to create database users with appropriate permissions
    """
    secret_arn = os.environ['SECRET_ARN']
    db_engine = os.environ['DB_ENGINE']
    
    try:
        # Get DB credentials from Secrets Manager
        secrets_manager = boto3.client('secretsmanager')
        secret_response = secrets_manager.get_secret_value(SecretId=secret_arn)
        secret = json.loads(secret_response['SecretString'])
        
        # Wait a bit for the database to be fully available (avoids connection issues)
        time.sleep(10)
        
        # Connect to the database and create users
        if 'postgresql' in db_engine:
            return setup_postgres_users(secret)
        elif 'mysql' in db_engine:
            return setup_mysql_users(secret)
        else:
            raise Exception(f"Unsupported DB engine: {db_engine}")
    except Exception as e:
        print(f"Error: {str(e)}")
        raise e

def setup_postgres_users(secret):
    """
    Create PostgreSQL users with read-only and read-write permissions
    """
    max_retries = 3
    retry_count = 0
    last_error = None
    
    while retry_count < max_retries:
        try:
            conn = psycopg2.connect(
                host=secret['host'],
                port=secret['port'],
                dbname=secret['dbname'],
                user=secret['username'],
                password=secret['password'],
                connect_timeout=10
            )
            
            conn.autocommit = True
            
            with conn.cursor() as cur:
                cur.execute("SELECT 1 FROM pg_roles WHERE rolname='readonly_user'")
                if cur.fetchone():
                    cur.execute("DROP USER readonly_user")
                
                cur.execute("SELECT 1 FROM pg_roles WHERE rolname='readwrite_user'")
                if cur.fetchone():
                    cur.execute("DROP USER readwrite_user")
                
                cur.execute(f"""
                    CREATE USER readonly_user WITH PASSWORD '{secret['readonly_password']}';
                    GRANT CONNECT ON DATABASE {secret['dbname']} TO readonly_user;
                    GRANT USAGE ON SCHEMA public TO readonly_user;
                    GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
                    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;
                """)
                
                cur.execute(f"""
                    CREATE USER readwrite_user WITH PASSWORD '{secret['readwrite_password']}';
                    GRANT CONNECT ON DATABASE {secret['dbname']} TO readwrite_user;
                    GRANT USAGE ON SCHEMA public TO readwrite_user;
                    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite_user;
                    GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite_user;
                    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite_user;
                    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite_user;
                """)
            
            return {'statusCode': 200, 'body': 'PostgreSQL users created successfully'}
        except Exception as e:
            last_error = e
            retry_count += 1
            print(f"Connection attempt {retry_count} failed: {str(e)}")
            time.sleep(5)
        finally:
            if 'conn' in locals() and conn:
                conn.close()
    
    raise last_error or Exception("Failed to connect to database after multiple attempts")

def setup_mysql_users(secret):
    """
    Create MySQL users with read-only and read-write permissions
    """
    max_retries = 3
    retry_count = 0
    last_error = None
    
    while retry_count < max_retries:
        try:
            conn = pymysql.connect(
                host=secret['host'],
                port=int(secret['port']),
                database=secret['dbname'],
                user=secret['username'],
                password=secret['password'],
                connect_timeout=10
            )
            
            with conn.cursor() as cur:
                cur.execute("DROP USER IF EXISTS 'readonly_user'@'%'")
                cur.execute("DROP USER IF EXISTS 'readwrite_user'@'%'")
                
                cur.execute(f"CREATE USER 'readonly_user'@'%' IDENTIFIED BY '{secret['readonly_password']}'")
                cur.execute(f"GRANT SELECT ON {secret['dbname']}.* TO 'readonly_user'@'%'")
                
                cur.execute(f"CREATE USER 'readwrite_user'@'%' IDENTIFIED BY '{secret['readwrite_password']}'")
                cur.execute(f"GRANT SELECT, INSERT, UPDATE, DELETE ON {secret['dbname']}.* TO 'readwrite_user'@'%'")
                
                cur.execute("FLUSH PRIVILEGES")
            
            conn.commit()
            return {'statusCode': 200, 'body': 'MySQL users created successfully'}
        except Exception as e:
            last_error = e
            retry_count += 1
            print(f"Connection attempt {retry_count} failed: {str(e)}")
            time.sleep(5)
        finally:
            if 'conn' in locals() and conn:
                conn.close()
    
    raise last_error or Exception("Failed to connect to database after multiple attempts")