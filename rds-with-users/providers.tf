provider "aws" {
  default_tags {
    tags = {
      Administrator      = "Nihal Castelino"
      ManagedByTerraform = "True"
    }
  }
  region = ""
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    role_arn       = "arn:aws:iam::12345678:role/terraform"
    region         = "eu-west-2"
    key            = "compute/serverless/terraform.tfstate"
    bucket         = "oc-dev-backend-storage"
    dynamodb_table = "oc-dev-backend-storage"
  }
}