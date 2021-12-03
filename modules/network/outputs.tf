output "first_public_network_id" {
  value = aws_subnet.test-project-first-public-network.id
}

output "second_public_network_id" {
  value = aws_subnet.test-project-second-public-network.id
}

output "first_private_network_id" {
  value = aws_subnet.test-project-first-private-network.id
}

output "second_private_network_id" {
  value = aws_subnet.test-project-second-private-network.id
}

output "vpc_id" {
  value = aws_vpc.test_project_vpc.id
}