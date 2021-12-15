variable "docker_tags" {
  description = "docker tags list"
  type = list(string)
}

variable "application_git_repository" {
  description = "A Git repository URI with dockerized application"
  type = string
}

variable "build_context" {
  description = "Absolute path to directory with application"
  type = string
}

variable "ecs_execution_role" {
  description = "role for task execution"
  type = string
}

variable "ecs_service_role" {
  description = "iam role for ecs services"
  type = string
}

variable "alb_backend_target_group" {
  description = "target group for backend service"
  type = string
}

variable "alb_frontend_target_group" {
  description = "target group for frontend service"
  type = string
}

variable "autoscaling_group_arn" {
  type = string
}