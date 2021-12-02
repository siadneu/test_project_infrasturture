output "key_pair" {
  value = aws_key_pair.key_pair.key_name
}
output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "main_security_group_id" {
  value = aws_security_group.http_private-ssh_8080.id
}