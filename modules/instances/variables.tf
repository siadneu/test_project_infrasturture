variable "subnet_ids" {
  type = list(string)
  description = "list of subnet ids"
}

variable "key_pair" {
  type = string
  description = "ssh key pair"
}

variable "bastion_security_group_id" {
  type = string
}

variable "main_security_group_id" {
  type = string
}

variable "http_security_group" {
  type = string
}

variable "jenkins_iam_role" {
  type = string
}

variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "targets" {
  description = "load balancer target groups"
  type = list(string)
}

variable "cluster_name" {
  description = "cluster_name"
  type = string
}