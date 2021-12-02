resource "aws_vpc" "test_project_vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "test_project_vpc"
  }
}