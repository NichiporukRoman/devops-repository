resource "aws_instance" "ubuntu" {
  ami = var.ami_ubuntu
  subnet_id = var.subnet_id  
  instance_type = var.type
  key_name  = var.keypair
  security_groups = [ var.security_group_id ]
  tags = {
    Name = "ubuntu"
  }
}

resource "aws_instance" "amazon" {
  ami = var.ami_amazon
  subnet_id = var.subnet_id  
  instance_type = var.type
  key_name  = var.keypair
  security_groups = [ var.security_group_id ]
  tags = {
    Name = "amazon"
  }
}