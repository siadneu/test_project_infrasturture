variable "vpc_id" {
  type = string
}

variable "my_cidr" {
  type = string
  description = "ips which will be granted access to the bastion host"
}

variable "bastion_ip" {
  type = string
  description = "bastion host's ip"
}