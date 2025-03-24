<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.aurora_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/db_subnet_group) | resource |
| [aws_kms_alias.mysql-alias](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.mysql](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.mysql](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/kms_key_policy) | resource |
| [aws_rds_cluster.aurora_serverless](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.aurora_instances](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/rds_cluster_instance) | resource |
| [aws_secretsmanager_secret.db_credentials](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.db_credentials](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.readonly_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.readwrite_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/iam_role) | data source |
| [aws_security_groups.rds_security_groups](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/security_groups) | data source |
| [aws_subnets.filtered_private](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acu_max"></a> [acu\_max](#input\_acu\_max) | aurora scaling max acu | `any` | n/a | yes |
| <a name="input_acu_min"></a> [acu\_min](#input\_acu\_min) | aurora scaling min acu | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy resources | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | cidr block to filter vpc | `any` | n/a | yes |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | Database engine type (aurora-mysql or aurora-postgresql) | `string` | n/a | yes |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | Database engine version | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | count of instances for aurora cluster | `any` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master username for the RDS cluster | `string` | n/a | yes |
| <a name="input_monitoring_role_name"></a> [monitoring\_role\_name](#input\_monitoring\_role\_name) | role for monitoring the db | `any` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | defines if subnet is public or private | `any` | n/a | yes |
| <a name="input_rds_security_group_name"></a> [rds\_security\_group\_name](#input\_rds\_security\_group\_name) | security group name for rds | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc name to filter the right vpc | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | n/a |
<!-- END_TF_DOCS -->