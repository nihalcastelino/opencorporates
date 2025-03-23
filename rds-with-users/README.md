<!-- BEGIN_TF_DOCS -->
## Requirements

- Requires the dev-vpc to have been pre created
- Requires the monitoring roles
   * cloudwatch permissions
   * allow rds to assume this role
Requires the terraform roles with permissions
   * all the permissions required for the role to create the rds and lambda
Requires lambda roles
   * lambda assume permissions
   * permissions to create the lambda and networking.
   * access secrets manager to read the passwords.


- Notes
* Terraform is unable to create DB users by default and hence the way to do it is to invoke an external script or in this case a lambda to create these DB ro/rw users.
* the RDS  master/read/write passwords are create using random.
* the above passwords are stored in secrets manager for the lamnda function to consume.


- Improvements
 * Current code is a bit static in the sense that a lambda will need to be created everytime a rds is spun up. the proper direction would be to have a single lambda that can be invoked anytime a rds is spun up
 
## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ../modules/lambda | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ../modules/rds | n/a |

## Resources

| Name | Type |
|------|------|
| [archive_file.lambda_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | n/a | `string` | `"10.32.0.0/20"` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | db engine | `string` | `"aurora-mysql"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Map of Default Tags | `map(any)` | <pre>{<br/>  "Administrator": "Nihal Castelino",<br/>  "Environment": "dev",<br/>  "ManagedByTerraform": "True"<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"test"` | no |
| <a name="input_external_file"></a> [external\_file](#input\_external\_file) | Path to an existing zip file | `string` | `null` | no |
| <a name="input_lambda_security_group_name"></a> [lambda\_security\_group\_name](#input\_lambda\_security\_group\_name) | n/a | `string` | `"rds-lambda-sg"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-2"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->