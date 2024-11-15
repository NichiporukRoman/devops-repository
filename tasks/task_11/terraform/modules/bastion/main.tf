resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id  
  key_name = var.keypair
  security_groups = [ var.security_group_id ]
  tags = {
    Name = "bastion"
  }
}
