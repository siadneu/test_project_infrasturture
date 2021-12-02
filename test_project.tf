provider "aws" {
  region = "us-east-2"
}

module "network" {
  source = "./modules/network"
}

module "instances" {
  source = "./modules/instances"

  subnet_ids = [module.network.first_public_network_id]
  key_pair = module.security.key_pair
  bastion_security_group_id = module.security.bastion_security_group_id
  main_security_group_id = module.security.main_security_group_id
  jenkins_iam_role = module.security.jenkins_iam_role
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id
  my_cidr = var.my_cidr
  bastion_ip = module.instances.bastion_ip
}