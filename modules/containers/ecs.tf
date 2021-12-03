resource "aws_ecs_cluster" "test-project" {
  name = "test-project"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

