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

module "security_group" {
    source = "./modules/security_group"
}


module "ec2" {
    source = "./modules/ec2" 
    security_group_id = module.security_group.security_group_id
}