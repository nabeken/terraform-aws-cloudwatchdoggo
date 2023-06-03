# IAM role
locals {
  source_zip = length(var.source_zip) > 0 ? var.source_zip : "cloudwatchdoggo_${var.source_version}_linux_amd64.zip"
}

resource "aws_dynamodb_table" "main" {
  name         = "${var.prefix}-cloudwatchdoggo"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "alarm_id"
  range_key    = "state_updated_at"

  deletion_protection_enabled = true

  attribute {
    name = "alarm_id"
    type = "S"
  }

  attribute {
    name = "state_updated_at"
    type = "N"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "main" {
  statement {
    sid = "cloudwatch"

    actions = [
      "cloudwatch:DescribeAlarms",
    ]

    resources = ["*"]
  }

  statement {
    sid = "logs"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.main.arn}:*",
    ]
  }

  statement {
    sid = "sns"

    actions = [
      "sns:Publish",
    ]

    resources = [var.sns_arn]
  }

  statement {
    sid = "ddb"

    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
    ]

    resources = [aws_dynamodb_table.main.arn]
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${var.prefix}-cloudwatchdoggo"
  retention_in_days = 14
}

resource "aws_iam_role" "main" {
  name               = "${var.prefix}-cloudwatchdoggo"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "main" {
  name   = "base"
  role   = aws_iam_role.main.id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_lambda_function" "main" {
  function_name    = "${var.prefix}-cloudwatchdoggo"
  role             = aws_iam_role.main.arn
  handler          = "cloudwatchdoggo"
  filename         = local.source_zip
  source_code_hash = filebase64sha256(local.source_zip)
  runtime          = "go1.x"
  timeout          = 60

  environment {
    variables = {
      DOGGO_TABLE_NAME    = aws_dynamodb_table.main.id
      DOGGO_BARK_SNS_ARN  = var.sns_arn
      DOGGO_BARK_INTERVAL = var.bark_interval
      DOGGO_DEBUG_ON      = var.debug_on
    }
  }
}

resource "aws_lambda_alias" "main" {
  name             = "main"
  description      = "the main version that receives the events"
  function_name    = aws_lambda_function.main.function_name
  function_version = var.event_main_version
}

resource "aws_cloudwatch_event_rule" "periodic" {
  name                = "${var.prefix}-cloudwatchdoggo"
  description         = "Poke the doggo"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.periodic.name
  arn  = aws_lambda_alias.main.arn
}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.periodic.arn
  qualifier     = aws_lambda_alias.main.name
}
