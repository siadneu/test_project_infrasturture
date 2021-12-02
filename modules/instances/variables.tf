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
