### main.tf
```
resource "aws_db_instance" "database" {
  allocated_storage = var.allocated_storage
  engine = var.engine
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = var.password
  skip_final_snapshot = true
  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible = true
  storage_type = var.storage_type
  multi_az = var.multi_az
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.name}-db-subnet-group"
  subnet_ids = [var.publick_subnet_id,var.private_subnet_id]
  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}
```

### outputs.tf
```
output "db_instance_identifier" {
  description = "Database Instance ID"
  value       = aws_db_instance.database.id
}

output "db_endpoint" {
  description = "Endpoint for connecting to the database"
  value       = aws_db_instance.database.endpoint
}
```

### varibles.tf
```
variable "allocated_storage" {
  description = "Storage size"
  type = number
  default = 20
}

variable "name" {
  description = "bd tags name"
  type = string
}

variable "engine" {
  description = "type of bd(Posgres, mysql)"
  type = string
}

variable "instance_class" {
  description = "Type of instance"
  type = string
  default = "db.t4g.micro"
}

variable "db_name" {
  description = "DB name"
  type = string
}

variable "username" {
  description = "DB user name"
  type = string
  sensitive = true
}

variable "password" {
  description = "User passwd"
  type = string
  sensitive = true
}


variable "publick_subnet_id" {
  description = "publick subnet ID for DB Subnet Group"
  type = string
}

variable "private_subnet_id" {
  description = "private subnet ID for DB Subnet Group"
  type = string
}

variable "sg_id" {
  description = "ID Security Group for DB access"
  type = string
}

variable "db_subnet_group_name" {
  description = "Name of subnet group for DB"
  type = string
}

variable "storage_type" {
  description = "Type of storage (gp2)"
  type = string
  default = "gp2"
}

variable "multi_az" {
  description = "Enable reusable mode for the database"
  type = bool
  default = false
}
```
