output "vpc_id" {
  value = aws_vpc.roman_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.roman_vpc.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.roman_subnet_public.id
}

output "public_private_id" {
  value = aws_subnet.roman_subnet_private.id
}

output "gateway_id" {
  value = aws_internet_gateway.roman_gateway.id
}