resource "aws_vpc" "roman_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "roman_vpc"
    }
}


resource "aws_internet_gateway" "roman_gateway" {
    vpc_id = aws_vpc.roman_vpc.id
    tags = {
        Name = "roman_gateway"
    }
}


resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.roman_vpc.id
    
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.roman_gateway.id
    }
    tags = {
        Name = "public_rt"
    }
}


resource "aws_eip" "nat_eip" {
    depends_on = [ aws_internet_gateway.roman_gateway ]
    tags = {
        Name = "nat_eip"
    }
}
