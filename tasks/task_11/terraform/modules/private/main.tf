resource "aws_instance" "private" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id  
  key_name = var.keypair
  tags = {
    Name = "private"
  }
}