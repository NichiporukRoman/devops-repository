
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = var.subnets

  tags = {
    Name = "rds_subnet_group"
  }
}

resource "aws_db_instance" "romandb" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  multi_az = false
  vpc_security_group_ids = [ var.security_group_id_rds ]
  skip_final_snapshot  = true
  tags = {
    Name = var.db_name
  }
}