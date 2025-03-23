terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "filtered_private" {
  for_each = toset(data.aws_availability_zones.azs.zone_ids)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  dynamic "filter" {
    for_each = var.purpose != null ? [var.purpose] : []
    content {
      name   = "tag:Name"
      values = ["${var.purpose}*"]
    }
  }

  filter {
    name   = "availability-zone-id"
    values = [each.value]
  }
}

locals {
  private_subnet_ids = compact(flatten([for k, v in data.aws_subnets.filtered_private : v.ids[0] if length(v.ids) > 0]))
}

data "aws_availability_zones" "azs" {}

data "aws_security_groups" "lambda_security_groups" {
  filter {
    name   = "tag:Name"
    values = [var.lambda_security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_iam_role" "role" {
  name = var.iam_role_name
}

output "subs" {
  value = data.aws_subnets.filtered_private
}


