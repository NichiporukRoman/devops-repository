resource "aws_vpc" "roman_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "roman_vpc"
    }
}


# Public 
resource "aws_subnet" "roman_subnet_public" {
    vpc_id = aws_vpc.roman_vpc.id
    cidr_block = var.vpc_cidr_public
    tags = {
        Name = "roman_subnet_public"
    }
}


# Private 
resource "aws_subnet" "roman_subnet_private" {
    vpc_id = aws_vpc.roman_vpc.id
    cidr_block = var.vpc_cidr_private
    tags = {
        Name = "roman_subnet_private"
    }
}


# Internet gateway
resource "aws_internet_gateway" "roman_gateway" {
    vpc_id = aws_vpc.roman_vpc.id
    tags = {
        Name = "roman_gateway"
    }
}

# Route table to acces to make public subnet - public
resource "aws_route_table" "second_rt" {
    vpc_id = aws_vpc.roman_vpc.id
    
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.roman_gateway.id
    }
    tags = {
        Name = "second_rt"
    }
}

# Assosiate route table with gateway
resource "aws_route_table_association" "public_subnet_asso" {
    subnet_id = aws_subnet.roman_subnet_public.id
    route_table_id = aws_route_table.second_rt.id
}