module "lambda" {
  source             = "../modules/lambda"
  cidr_block         = var.cidr_block
  enable_environment = true
  environment        = var.environment
  environment_variables = {
    SECRET_ARN = module.rds.secret_arn
    DB_ENGINE  = var.db_engine
  }
  zip_file_path              = data.archive_file.lambda_zip.output_path
  source_code_hash           = data.archive_file.lambda_zip.output_base64sha256
  function_name              = "rds-users"
  iam_role_name              = "rds-lambda-role"
  lambda_alias               = "rds-users"
  lambda_security_group_name = var.lambda_security_group_name
  purpose                    = "private-subnet"
  runtime                    = "python3.13"
  vpc_name                   = "dev-vpc"
  depends_on = [ module.rds ]
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/files/lambda_function.py" # Or source_dir if needed
  output_path = "${path.module}/lambda_function.zip"
}


module "rds" {
  source                  = "../modules/rds"
  cidr_block              = var.cidr_block
  db_engine               = var.db_engine
  db_engine_version       = "3.07.0"
  vpc_name                = "dev-vpc"
  purpose                 = "private-subnet"
  acu_max                 = 4.0
  acu_min                 = 0.5
  monitoring_role_name    = "rds_cloudwatch"
  aws_region              = "eu-west-2"
  db_name                 = "test"
  instance_count          = 1
  master_username         = "admin"
  rds_security_group_name = "rds-test-security-group"
}

resource "aws_lambda_invocation" "setup_db_users_invoke" {
  function_name = module.lambda.lambda_name
  input = jsonencode({
    action = "create_users"
  })

  depends_on = [
    module.lambda,
    module.rds
  ]

  # Only run this once
  triggers = {
    # Generate a new uuid each time to force redeployment - normally you'd use a better trigger
    redeployment = uuid()
  }
}