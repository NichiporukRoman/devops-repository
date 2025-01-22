```
provider "aws" {
  region = "us-west-2"
}

data "aws_secretsmanager_secret_version" "pass" {
  secret_id = "RDS"
}

locals {
  db_pass = jsondecode(
    data.aws_secretsmanager_secret_version.pass.secret_string
  )
}

module "rds" {
  source               = "./modules/rds"
  name                 = "rds"
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = "db.t4g.micro"
  db_name              = "mydatabase"
  username             = local.db_pass.username
  password             = local.db_pass.password
  private_subnet_id    = module.vpc.private_subnet_id
  publick_subnet_id    = module.vpc.public_subnet_id
  sg_id                = module.security_group.rds_sg_id
  db_subnet_group_name = "db-subnet-group"
  storage_type         = "gp2"
  multi_az             = false
}

module "security_group" {
  source          = "./modules/security_group"
  name            = "SG"
  vpc_id          = module.vpc.vpc_id
  allowed_ssh_ip  = var.allowed_ssh_ip
  allowed_db_cidr_block = var.allowed_db_cidr_block
}

module "vpc" {
  source = "./modules/vpc"
  name = "vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  public_az = "us-west-2a"
  private_az = "us-west-2b"
}

module "bastion" {
  source        = "./modules/bastion"
  name          = "bastion"
  ami           = var.ami
  key_name      = "r2"
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.security_group.bastion_sg_id
}

module "private_server" {
  source        = "./modules/private_server"
  name          = "private server"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet_id
  sg_id         = module.security_group.private_sg_id
  key_name      = "r2"
}

```