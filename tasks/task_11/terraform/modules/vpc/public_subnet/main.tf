resource "aws_subnet" "roman_subnet_public" {
    availability_zone = var.aws_az
    vpc_id = var.roman_vpc_id
    map_public_ip_on_launch = true
    cidr_block = var.vpc_cidr_public
    tags = {
        Name = "roman_subnet_public"
    }
}


resource "aws_route_table_association" "public_subnet_asso" {
    subnet_id = aws_subnet.roman_subnet_public.id
    route_table_id = var.public_rt_id
}


resource "aws_nat_gateway" "roman_nat" {
    allocation_id = var.nat_eip_id
    subnet_id     = aws_subnet.roman_subnet_public.id
    tags = {
        Name = "roman_nat_gateway"
    }
}