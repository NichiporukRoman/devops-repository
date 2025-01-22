### main.tf
```
resource "aws_security_group" "bastion_sg" {
    name = "${var.name}-bastion-sg"
    description = "Security group for bastion host"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.allowed_ssh_ip]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_security_group" "private_sg" {
    name = "${var.name}-private-sg"
    description = "Security group for private server"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.name}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432 
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### outputs.tf
```
output "bastion_sg_id" {
  description = "ID of the bastion host security group"
  value       = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  description = "ID of the private server security group"
  value       = aws_security_group.private_sg.id
}

output "rds_sg_id" {
  description = "ID of the RDS security group"
  value = aws_security_group.rds_sg.id
}


```

### variables.tf
```
variable "name" {
  description = "Base name for resources"
  type = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "allowed_ssh_ip" {
  description = "IP address allowed to access SSH"
  type        = string
}

variable "allowed_db_cidr_block" {
  description = "CIDR block for RDS"
  type        = string
}

```