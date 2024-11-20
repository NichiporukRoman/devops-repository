provider "aws" {}


module "vpc" {
  source = "./modules/vpc/vpc_base"
}


module "public_subnet" {
  source = "./modules/vpc/public_subnet"
  nat_eip_id = module.vpc.nat_eip_id
  roman_vpc_id = module.vpc.vpc_id
  public_rt_id = module.vpc.public_rt_id
}


module "private_subnet" {
  source = "./modules/vpc/private_subnet"
  roman_vpc_id = module.vpc.vpc_id
  nat_id = module.public_subnet.nat_id
}


module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


module "bastion" {
  source = "./modules/bastion"
  security_group_id = module.security_group.security_group_id
  subnet_id = module.public_subnet.public_subnet_id
}


module "private" {
  source = "./modules/private"
  subnet_id = module.private_subnet.private_subnet_id
}


resource "aws_secretsmanager_secret" "db_password" {
  name = "db_password1"
}


resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.secret
}


module "rds" {
  source = "./modules/rds"
  password = aws_secretsmanager_secret_version.db_password.secret_string
  subnets = [ module.public_subnet.public_subnet_id, module.private_subnet.private_subnet_id ] 
  security_group_id_rds = module.security_group.security_group_id_rds
}


terraform {
  backend "s3" {
    bucket         = "mybucketroman"  
    key            = "terraform.tfstate" 
    region         = "us-east-1"              
    encrypt        = true                 
    dynamodb_table = "terraform-state-lock"          
  }
}