resource "aws_security_group" "sg_group" {
    name = "sg_group"
    description = "Security group"
    vpc_id = var.vpc_id

    ingress {
        description = var.object.name
        from_port = 22
        to_port = 22
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 80
        to_port = 80
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }

    ingress {
        description = var.object.name
        from_port = 443
        to_port = 443
        protocol = "tcp"
#       cidr_blocks = ["178.127.202.237/32"]
        cidr_blocks = var.object.adresses
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

