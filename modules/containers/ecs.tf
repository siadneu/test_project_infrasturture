resource "aws_ecs_cluster" "test-project" {
  name = "test-project"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_service" "backend" {
  name = "backend"
  cluster = aws_ecs_cluster.test-project.arn
  desired_count = 2
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  launch_type = "EC2"
  scheduling_strategy = "REPLICA"
  enable_ecs_managed_tags = true
  health_check_grace_period_seconds = 0
  iam_role = var.ecs_service_role
  task_definition = "${aws_ecs_task_definition.backend.family}:${aws_ecs_task_definition.backend.revision}"
  load_balancer {
    container_name = "backend"
    container_port = 80
    target_group_arn = var.alb_backend_target_group
  }
  ordered_placement_strategy {
    type = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type = "spread"
    field = "instanceId"
  }
}

resource "aws_ecs_service" "frontend" {
  name = "frontend"
  cluster = aws_ecs_cluster.test-project.arn
  desired_count = 2
  deployment_maximum_percent = 200
   deployment_minimum_healthy_percent = 100
  launch_type = "EC2"
  scheduling_strategy = "REPLICA"
  enable_ecs_managed_tags = true
  health_check_grace_period_seconds = 0
  iam_role = var.ecs_service_role
  task_definition = "${aws_ecs_task_definition.frontend.family}:${aws_ecs_task_definition.frontend.revision}"
  load_balancer {
    container_name = "frontend"
    container_port = 80
    target_group_arn = var.alb_frontend_target_group
  }
  ordered_placement_strategy {
    type = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type = "spread"
    field = "instanceId"
  }
}