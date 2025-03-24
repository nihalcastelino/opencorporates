# Use a random password generator instead of requiring a variable
resource "random_password" "master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "readonly_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "readwrite_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.environment}/aurora/credentials"
  description = "RDS Aurora Serverless database credentials"

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username            = var.master_username
    password            = random_password.master_password.result
    engine              = var.db_engine
    host                = aws_rds_cluster.aurora_serverless.endpoint
    port                = var.db_engine == "aurora-mysql" ? 3306 : 5432
    dbname              = var.db_name
    dbClusterIdentifier = aws_rds_cluster.aurora_serverless.id
    readonly_user       = "readonly_user"
    readonly_password   = random_password.readonly_password.result
    readwrite_user      = "readwrite_user"
    readwrite_password  = random_password.readwrite_password.result
  })

  depends_on = [aws_rds_cluster.aurora_serverless]
}

resource "aws_kms_key" "mysql" {
  is_enabled = true
}

resource "aws_kms_alias" "mysql-alias" {
  target_key_id = aws_kms_key.mysql.id
}

# resource "aws_kms_key_policy" "mysql" {
#   key_id = aws_kms_key.mysql.id
#   policy = data.aws_iam_policy_document.kms.json
# }
