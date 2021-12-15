output "key_pair" {
  value = aws_key_pair.key_pair.key_name
}
output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "main_security_group_id" {
  value = aws_security_group.http_private-ssh_8080.id
}

output "http_security_group" {
  value = aws_security_group.http.id
}

output "jenkins_iam_role" {
  value = aws_iam_role.jenkins_role.name
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ecs_service_role_arn" {
  value = aws_iam_role.ecsServiceRole.name
}