variable "region" {
  description = "AWS Region where the lambda function will be deployed"
  type        = string
}

variable "prefix" {
  description = "A prefix used for resources created by this module"
  type        = string
}

variable "source_zip" {
  type        = string
  description = "A path to custom zip file. You still have to place a zip file in the working directly before invoking terraform. If not specified, terraform will try to locate a zp file based on the `source_version` variable."
  default     = ""
}

variable "sns_arn" {
  type        = string
  description = "A SNS ARN to bark. It should be a topic where AWS Chatbot subscribes."
}

variable "debug_on" {
  type        = string
  description = "Set to 'true' if you want to enable the debug mode "
  default     = "true"
}
