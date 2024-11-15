output "vpc_id" {
  value = aws_vpc.roman_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.roman_vpc.cidr_block
}

output "gateway_id" {
  value = aws_internet_gateway.roman_gateway.id
}

output "nat_eip_id" {
  value = aws_eip.nat_eip.id
}

output "public_rt_id" {
  value = aws_route_table.public_rt.id
}