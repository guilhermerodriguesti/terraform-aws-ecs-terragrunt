
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "webapp-dev01-terraform-state"
    key = "webapps/dev/us-east-1/ecs-cluster/front/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "webapps-dev-lock-table"
  }
}