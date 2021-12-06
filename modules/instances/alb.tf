resource "aws_lb" "test_project_alb" {
  name = "test-project"
  subnets = [var.subnet_ids[0],
             var.subnet_ids[1]]
  security_groups = [var.http_security_group]
  ip_address_type = "ipv4"

}
