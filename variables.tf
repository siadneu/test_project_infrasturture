variable "my_cidr" {
  type = string
  description = "ips which will be granted access to the bastion host"
}

variable "build_context" {
  description = "Absolute path to directory with application"
  type = string
}