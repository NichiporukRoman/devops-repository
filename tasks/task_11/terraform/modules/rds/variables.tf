variable "subnets" {
    type = list(string)
}


variable "db_name" {
    type = string
    default = "romandb"
}


variable "engine" {
    type = string
    default = "mysql"
}


variable "engine_version" {
    type = string
    default = "8.0"
}


variable "instance_class" {
    type = string
    default = "db.t3.micro"
}


variable "username" {
    type = string
    default = "username"
}


variable "password" {
    type = string
    default = "password"
}


variable "parameter_group_name" {
    type = string
    default = "default.mysql8.0"
}


variable "security_group_id_rds" {
  type = string
}