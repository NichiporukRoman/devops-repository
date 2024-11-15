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


module "rds" {
  source = "./modules/rds"
  subnets = [ module.public_subnet.public_subnet_id, module.private_subnet.private_subnet_id ] 
  security_group_id_rds = module.security_group.security_group_id_rds
}
