output "bastion_ip" {
  value = aws_instance.bastion.private_ip
}

output "alb_name" {
  value = aws_lb.test_project_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.test_project_alb.zone_id
}

output "backend_target_group" {
  value = aws_lb_target_group.tg["backend"].arn
}

output "frontend_target_group" {
  value = aws_lb_target_group.tg["frontend"].arn
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.ecs_placement_group.arn
}