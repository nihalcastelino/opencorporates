<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_alias.lambda_alias](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.lambda-function](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/resources/lambda_function) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/iam_role) | data source |
| [aws_security_groups.lambda_security_groups](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/security_groups) | data source |
| [aws_subnets.filtered_private](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/5.81.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | n/a | `any` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Map of Default Tags | `map(any)` | <pre>{<br/>  "Administrator": "Nihal Castelino",<br/>  "Environment": "dev",<br/>  "ManagedByTerraform": "True"<br/>}</pre> | no |
| <a name="input_enable_environment"></a> [enable\_environment](#input\_enable\_environment) | Whether to enable the environment block | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Map of environment variables to pass to the resource | `map(string)` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | n/a | `any` | n/a | yes |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_alias"></a> [lambda\_alias](#input\_lambda\_alias) | n/a | `any` | n/a | yes |
| <a name="input_lambda_security_group_name"></a> [lambda\_security\_group\_name](#input\_lambda\_security\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | n/a | `any` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | n/a | `any` | n/a | yes |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | n/a | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `any` | n/a | yes |
| <a name="input_zip_file_path"></a> [zip\_file\_path](#input\_zip\_file\_path) | Full path to the Lambda deployment package zip | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subs"></a> [subs](#output\_subs) | n/a |
<!-- END_TF_DOCS -->