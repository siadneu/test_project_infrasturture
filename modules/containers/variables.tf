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