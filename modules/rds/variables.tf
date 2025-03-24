variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string

}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "db_engine" {
  description = "Database engine type (aurora-mysql or aurora-postgresql)"
  type        = string

}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string

}

variable "db_name" {
  description = "Database name"
  type        = string

}

variable "master_username" {
  description = "Master username for the RDS cluster"
  type        = string

}

variable "instance_count" {
  description = "count of instances for aurora cluster"
}

variable "acu_max" {
  description = "aurora scaling max acu"
}

variable "acu_min" {
  description = "aurora scaling min acu"
}

variable "monitoring_role_name" {
  description = "role for monitoring the db"
}

variable "cidr_block" {
  description = "cidr block to filter vpc"
}
variable "rds_security_group_name" {
  description = "security group name for rds"
}

variable "vpc_name" {
  description = "vpc name to filter the right vpc"
}

variable "purpose" {
  description = "defines if subnet is public or private"
}