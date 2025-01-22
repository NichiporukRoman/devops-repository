### main.tf
```
resource "aws_instance" "bastion" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  security_groups = [var.sg_id]
  key_name = var.key_name
  user_data = "${file("inst_db.sh")}"

  provisioner "remote-exec" {
    inline = [
      "echo '${file("C:\\Users\\leon1\\Desktop\\terraform\\r2.pem")}' > /home/ubuntu/r2.pem",
      "chmod 600 /home/ubuntu/r2.pem",
      "chown ubuntu:ubuntu /home/ubuntu/r2.pem"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:\\Users\\leon1\\Desktop\\terraform\\r2.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "${var.name}-bastion"
  }
}
```

### outputs.tf
```
output "bastion_id" {
  description = "Bastion ID"
  value = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Bastion public IP"
  value = aws_instance.bastion.public_ip
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
  description = "Bastion instance type "
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "public subnet ID for Bastion"
  type = string
}

variable "sg_id" {
  description = "Bastion security group ID"
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