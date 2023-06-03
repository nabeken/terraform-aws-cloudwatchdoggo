provider "aws" {
  region = var.region
}

module "cloudwatch" {
  source = "../"

  prefix     = var.prefix
  source_zip = var.source_zip
  sns_arn    = var.sns_arn
}
