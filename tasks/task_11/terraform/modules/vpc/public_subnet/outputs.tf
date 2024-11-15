output "public_subnet_id" {
  value = aws_subnet.roman_subnet_public.id
}


output "nat_id" {
  value = aws_nat_gateway.roman_nat.id
}
