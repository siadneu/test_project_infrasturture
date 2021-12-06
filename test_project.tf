module "network" {
  source = "./modules/network"
}

module "instances" {
  source = "./modules/instances"

  subnet_ids = [module.network.first_public_network_id,
                module.network.second_public_network_id,
                module.network.first_private_network_id,
                module.network.second_private_network_id]
  key_pair = module.security.key_pair
  bastion_security_group_id = module.security.bastion_security_group_id
  main_security_group_id = module.security.main_security_group_id
  jenkins_iam_role = module.security.jenkins_iam_role
  vpc_id = module.network.vpc_id
  http_security_group = module.security.http_security_group
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id
  my_cidr = var.my_cidr
  bastion_ip = module.instances.bastion_ip
}

module "s3" {
  source = "./modules/s3"
}

module "containers" {
  source = "./modules/containers"
  docker_tags = ["backend", "frontend"]
  application_git_repository = "git@github.com:siadneu/test_project.git"
  build_context = var.build_context
  ecs_execution_role = module.security.ecs_execution_role_arn
}