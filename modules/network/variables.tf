variable "domain_name" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}