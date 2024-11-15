resource "aws_subnet" "roman_subnet_private" {
    availability_zone = "us-east-1b"
    vpc_id = var.roman_vpc_id
    cidr_block = var.vpc_cidr_private
    tags = {
        Name = "roman_subnet_private"
    }
}


resource "aws_route_table" "private_rt" {
    vpc_id = var.roman_vpc_id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = var.nat_id
    }

    tags = {
        Name = "private_rt"
    }
}


resource "aws_route_table_association" "private_subnet_asso" {
    subnet_id      = aws_subnet.roman_subnet_private.id
    route_table_id = aws_route_table.private_rt.id
}
