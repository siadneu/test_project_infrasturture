output "first_public_network_id" {
  value = aws_subnet.test-project-first-public-network.id
}

output "vpc_id" {
  value = aws_vpc.test_project_vpc.id
}