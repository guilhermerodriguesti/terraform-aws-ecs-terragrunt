locals {
  aws_region = "us-east-1"
  account_id = "0123456789"
  stack = "webapps/dev/us-east-1/ecs/front"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "${local.account_id}-terraform-state-ecs-clusters"
    key = "${local.stack}/${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "${local.account_id}-ecs-clusters-terraform-lock"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
}
EOF
}