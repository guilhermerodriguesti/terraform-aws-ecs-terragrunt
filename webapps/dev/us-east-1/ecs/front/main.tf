variable "environment" {}
variable "app_type" {}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-webapps-${var.app_type}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}