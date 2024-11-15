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

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


resource "aws_security_group" "rds_sg_group" {
    name = "rds_sg_group"
    description = "Security group for rds"
    vpc_id = var.vpc_id

    ingress {
        description = "security group"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.sg_group.id ]
    }


}