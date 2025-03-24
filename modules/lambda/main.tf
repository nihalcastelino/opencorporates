resource "aws_lambda_function" "lambda-function" {
  function_name    = var.function_name
  role             = data.aws_iam_role.role.arn
  handler          = "lambda_function.handler"
  runtime          = var.runtime
  timeout          = 180
  filename         = var.zip_file_path
  source_code_hash = var.source_code_hash


  dynamic "environment" {
    for_each = var.enable_environment && length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }
  vpc_config {
    subnet_ids         = [for subnet in local.private_subnet_ids : subnet]
    security_group_ids = data.aws_security_groups.lambda_security_groups.ids
  }
}

resource "aws_lambda_alias" "lambda_alias" {
  name             = var.lambda_alias
  description      = "alias for the lambda function"
  function_name    = aws_lambda_function.lambda-function.function_name
  function_version = "$LATEST"
}

