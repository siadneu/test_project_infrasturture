resource "aws_ecs_task_definition" "frontend" {
  family                = "fronyend"
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions = <<TASK_DEFINITION
    [{
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ],
      "cpu": 0,
      "environment": [
        {
          "name": "BACKEND_URL",
          "value": "http://api.siadneuihar.click"
        }
      ],
      "mountPoints": [],
      "memory": 256,
      "volumesFrom": [],
      "image": "${docker_registry_image.TestProjectImages["frontend"].name}",
      "name": "frontend"
    }
  ]
  TASK_DEFINITION
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  task_role_arn            = var.ecs_execution_role
  requires_compatibilities = ["EC2"]
  container_definitions    = <<TASK_DEFINITION
   [
    {
      "portMappings": [
        {
          "hostPort": 8080,
          "protocol": "tcp",
          "containerPort": 80
        }
      ],
      "cpu": 0,
      "environment": [
        {
          "name": "AWS_REGION_NAME",
          "value": "us-east-2"
        },
        {
          "name": "FRONTEND_URL",
          "value": "siadneuihar.click"
        },
        {
          "name": "MESSAGES_FILE",
          "value": "messages.txt"
        },
        {
          "name": "S3_BUCKET",
          "value": "testprojectmessages"
        }
      ],
      "mountPoints": [],
      "memory": 256,
      "volumesFrom": [],
      "image": "${docker_registry_image.TestProjectImages["backend"].name}",
      "essential": true,
      "name": "backend"
    }
  ]
  TASK_DEFINITION
}