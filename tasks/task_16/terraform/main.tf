terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "jenkins" {
    source = "./modules/jenkins"
}

module "target" {
    source = "./modules/target" 
    object = {
      name = "sg_group"
      adresses = ["${module.jenkins.ubuntu_ip}/32"]
    }
}