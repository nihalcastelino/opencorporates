variable "default_tags" {
  type        = map(any)
  description = "Map of Default Tags"
  default = {
    Administrator      = "Nihal Castelino"
    ManagedByTerraform = "True"
    Environment        = "dev"
  }
}

variable "environment" {}
variable "cidr_block" {}
variable "lambda_security_group_name" {}
variable "vpc_name" {}
variable "purpose" {}

variable "environment_variables" {
  description = "Map of environment variables to pass to the resource"
  type        = map(string)
}

variable "enable_environment" {
  description = "Whether to enable the environment block"
  type        = bool
}

variable "function_name" {}
variable "lambda_alias" {}
variable "iam_role_name" {}
variable "runtime" {}
variable "source_code_hash" {}
variable "zip_file_path" {
  description = "Full path to the Lambda deployment package zip"
  type        = string
}