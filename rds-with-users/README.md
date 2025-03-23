<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

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