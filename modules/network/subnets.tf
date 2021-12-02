resource "aws_subnet" "test-project-first-private-network" {
  vpc_id                  = aws_vpc.test_project_vpc.id
  cidr_block              = "10.0.0.0/26"
  map_public_ip_on_launch = false
  tags = {
    Name = "test-project-first-private-network"
  }
}

resource "aws_subnet" "test-project-second-private-network" {
  vpc_id                  = aws_vpc.test_project_vpc.id
  cidr_block              = "10.0.0.64/26"
  map_public_ip_on_launch = false
  tags   = {
    Name = "test-project-second-private-network"
  }
}

resource "aws_subnet" "test-project-first-public-network" {
  cidr_block              = "10.0.0.128/26"
  vpc_id                  = aws_vpc.test_project_vpc.id
  map_public_ip_on_launch = true
  tags   = {
    Name = "test-project-first-public-network"
  }
}

resource "aws_subnet" "test-project-second-public-network" {
  cidr_block              = "10.0.0.192/26"
  vpc_id                  = aws_vpc.test_project_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = 	"test-project-second-public-network"
  }
}