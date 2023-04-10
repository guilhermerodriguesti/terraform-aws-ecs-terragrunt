variable "environment" {}
variable "app_type" {}
variable "service_name" {}


resource "aws_ecs_service" "api" {
  name            = "${var.service_name}"
  cluster         = "ecs-webapps-${var.app_type}-${var.environment}"
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 3

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
  }
}

resource "aws_ecs_task_definition" "service" {
  family = "${var.service_name}"
  container_definitions = jsonencode([
    {
      name      = "first-${var.service_name}-${var.environment}"
      image     = "public.ecr.aws/nginx/nginx:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
  }
}