# terraform-aws-cloudwatchdoggo

[![Pre-Commit](https://github.com/nabeken/terraform-aws-cloudwatchdoggo/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/nabeken/terraform-aws-cloudwatchdoggo/actions/workflows/pre-commit.yml)

`terraform-aws-cloudwatchdoggo` is a Terraform module that provisions [nabeken/cloudwatchdoggo](https://github.com/nabeken/cloudwatchdoggo).

## Prerequisite

You need to place a zip file that contains the `cloudwatchdoggo` binary as `bootstrap` into a terraform's working directly before invoking terraform. This is because the module will use `provided.al2` runtime instead.

You can find an example script to download the upstream zip file in `scripts` directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.periodic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_dynamodb_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bark_interval"></a> [bark\_interval](#input\_bark\_interval) | An interval to bark again since the last bark. It must be string that Go's time.ParseDuration accepts. | `string` | `"10m"` | no |
| <a name="input_debug_on"></a> [debug\_on](#input\_debug\_on) | Set to 'true' if you want to enable the debug mode | `string` | `"false"` | no |
| <a name="input_event_main_version"></a> [event\_main\_version](#input\_event\_main\_version) | The version of the Lambda function that receivets the events | `string` | `"$LATEST"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A prefix used for the resources created by this module | `string` | n/a | yes |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | A interval to poke the doggo via CloudWatch Events. It must follow CloudWatch Evetns's schedule expression. | `string` | `"rate(1 minute)"` | no |
| <a name="input_sns_arn"></a> [sns\_arn](#input\_sns\_arn) | A SNS ARN to bark. It should be a topic where AWS Chatbot subscribes. | `string` | n/a | yes |
| <a name="input_source_version"></a> [source\_version](#input\_source\_version) | A version of the upstream release | `string` | `"0.0.2"` | no |
| <a name="input_source_zip"></a> [source\_zip](#input\_source\_zip) | A path to custom zip file. You still have to place a zip file in the working directly before invoking terraform. If not specified, terraform will try to locate a zip file based on the `source_version` variable. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
