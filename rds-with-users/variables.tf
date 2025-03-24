variable "default_tags" {
  type        = map(any)
  description = "Map of Default Tags"
  default = {
    Administrator      = "Nihal Castelino"
    ManagedByTerraform = "True"
    Environment        = "dev"
  }
}

variable "environment" {
  default = "test"
}


variable "region" {
  default = "eu-west-2"
}


variable "cidr_block" {
  default = "10.32.0.0/20"
}


variable "lambda_security_group_name" {
  default = "rds-lambda-sg"
}

variable "external_file" {
  description = "Path to an existing zip file"
  type        = string
  default     = null
}

variable "db_engine" {
  description = "db engine"
  default     = "aurora-mysql"
}