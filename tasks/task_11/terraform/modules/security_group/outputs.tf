output "security_group_id" {
    value = aws_security_group.sg_group.id
}

output "security_group_id_rds" {
    value = aws_security_group.rds_sg_group.id
}