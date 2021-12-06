resource "aws_lb" "test_project_alb" {
  name            = "test-project"
  subnets         = [var.subnet_ids[0],
                     var.subnet_ids[1]]
  security_groups = [var.http_security_group]
  ip_address_type = "ipv4"

}

resource "aws_lb_target_group" "tg" {
  for_each = toset(var.targets)
  name                  = each.value
  target_type           = "instance"
  vpc_id                = var.vpc_id
  port                  = 80
  protocol              = "HTTP"
  protocol_version      = "HTTP1"
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2

  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.test_project_alb.arn
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg["frontend"].arn
  }
}

resource "aws_lb_listener_rule" "backend" {
  listener_arn = aws_lb_listener.listener.arn
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg["backend"].arn
  }
  condition {
    host_header {
      values = ["api.siadneuihar.click"]
    }
  }
}