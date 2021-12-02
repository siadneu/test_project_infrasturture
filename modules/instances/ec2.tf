resource "aws_instance" "bastion" {
  instance_type = "t2.micro"
  ami = "ami-0d718c3d715cec4a7"
  key_name = var.key_pair
  subnet_id = var.subnet_ids[0]
  vpc_security_group_ids = [var.bastion_security_group_id]
  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "jenkins" {
  instance_type = "t2.micro"
  ami = "ami-0629230e074c580f2"
  key_name = var.key_pair
  subnet_id = var.subnet_ids[0]
  vpc_security_group_ids = [var.main_security_group_id]
  iam_instance_profile = var.jenkins_iam_role
  tags = {
    Name = "jenkins"
  }
}