resource "aws_route_table" "test_project_public" {
  vpc_id = aws_vpc.test_project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-project-internet-gateway.id
  }
}

resource "aws_route_table" "test_project_private" {
  vpc_id = aws_vpc.test_project_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test-project-nat-gateway.id
  }
  tags   = {
    Name = "test-project-private"
  }
}

resource "aws_route_table_association" "private-1" {
  route_table_id = aws_route_table.test_project_private.id
  subnet_id = aws_subnet.test-project-first-private-network.id
}

resource "aws_route_table_association" "private-2" {
  route_table_id = aws_route_table.test_project_private.id
  subnet_id = aws_subnet.test-project-second-private-network.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test_project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-project-internet-gateway.id
  }
  tags = {
    Name = "public networks gateway"
  }
}

resource "aws_route_table_association" "public1" {
  route_table_id = aws_route_table.test_project_public.id
  subnet_id = aws_subnet.test-project-first-public-network.id
}

resource "aws_route_table_association" "public2" {
  route_table_id = aws_route_table.test_project_public.id
  subnet_id = aws_subnet.test-project-second-public-network.id
}