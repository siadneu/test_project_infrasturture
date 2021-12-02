resource "aws_eip" "nat-gateway-ip" {
  vpc = true
}