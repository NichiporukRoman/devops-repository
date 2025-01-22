### main.ft
```
resource "aws_instance" "private" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = false
  security_groups = [var.sg_id]
  key_name = var.key_name
  user_data = "${file("inst_db.sh")}"
  

  tags = {
    Name = "${var.name}-private-server"
  }
  
}
```
### outputs.tf

```
output "private_server_id" {
  description = "Prvate server ID"
  value = aws_instance.private.id
}
```
### variables.tf
```
variable "ami" {
  description = "AMI ID EC2"
  type = string
  default = "ami-04dd23e62ed049936"
}

variable "instance_type" {
  description = "Private-server instance type "
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "public subnet ID for private-server"
  type = string
}

variable "sg_id" {
  description = "Private-server security group ID"
  type = string
}

variable "name" {
  description = "name (EC2)"
  type = string
}
variable "key_name" {
  description = "key name"
  type = string
}
```