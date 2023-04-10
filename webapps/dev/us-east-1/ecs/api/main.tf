resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-webapps-api-dev"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}