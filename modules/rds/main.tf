# Create DB subnet group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.environment}-aurora-subnet-group"
  subnet_ids = local.private_subnet_ids

  tags = {
    Name        = "${var.environment}-aurora-subnet-group"
    Environment = var.environment
  }
}


# Create Aurora Serverless cluster
resource "aws_rds_cluster" "aurora_serverless" {
  cluster_identifier      = "${var.environment}-aurora-serverless"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  engine_mode             = "provisioned"
  database_name           = var.db_name
  master_username         = var.master_username
  master_password         = random_password.master_password.result
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = data.aws_security_groups.rds_security_groups
  skip_final_snapshot     = true
  backup_retention_period = 7
  preferred_backup_window = "03:00-05:00"
  kms_key_id              = aws_kms_key.mysql.arn
  serverlessv2_scaling_configuration {
    min_capacity = var.acu_min # Min ACU
    max_capacity = var.acu_min # Max ACU
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Create DB instance in the cluster (using Serverless v2)
resource "aws_rds_cluster_instance" "aurora_instances" {
  count               = var.instance_count
  identifier          = "${var.environment}-aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora_serverless.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.aurora_serverless.engine
  engine_version      = aws_rds_cluster.aurora_serverless.engine_version
  monitoring_role_arn = data.aws_iam_role.role.arn
  tags = {
    Environment = var.environment
  }
}

