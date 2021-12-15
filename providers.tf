terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "docker" {
  registry_auth {
    address = split("://", module.containers.repository_url)[1]
    username = module.containers.ecr_token.user_name
    password = module.containers.ecr_token.password
  }
}