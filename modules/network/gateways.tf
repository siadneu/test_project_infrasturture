resource "aws_internet_gateway" "test-project-internet-gateway" {
  vpc_id = aws_vpc.test_project_vpc.id
  tags   = {
    Name = "test-project-internet-gateway"
  }
}

resource "aws_nat_gateway" "test-project-nat-gateway" {
  subnet_id = aws_subnet.test-project-second-public-network.id
  allocation_id = aws_eip.nat-gateway-ip.id
  tags      = {
    Name    = "test-project"
  }
}