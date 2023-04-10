variable "env" {}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-webapps-api-${var.env}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}