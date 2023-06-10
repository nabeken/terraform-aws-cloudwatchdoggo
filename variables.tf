variable "prefix" {
  type        = string
  description = "A prefix used for the resources created by this module"
}

variable "source_version" {
  type        = string
  description = "A version of the upstream release"
  default     = "0.0.3"
}

variable "source_zip" {
  type        = string
  description = "A path to custom zip file. You still have to place a zip file in the working directly before invoking terraform. If not specified, terraform will try to locate a zip file based on the `source_version` variable."
  default     = ""
}

variable "sns_arn" {
  type        = string
  description = "A SNS ARN to bark. It should be a topic where AWS Chatbot subscribes."
}

variable "event_main_version" {
  type        = string
  description = "The version of the Lambda function that receivets the events"
  default     = "$LATEST"
}

variable "debug_on" {
  type        = string
  description = "Set to 'true' if you want to enable the debug mode "
  default     = "false"
}

variable "bark_interval" {
  type        = string
  description = "An interval to bark again since the last bark. It must be string that Go's time.ParseDuration accepts."
  default     = "10m"
}

variable "schedule_expression" {
  type        = string
  description = "A interval to poke the doggo via CloudWatch Events. It must follow CloudWatch Evetns's schedule expression."
  default     = "rate(1 minute)"
}
