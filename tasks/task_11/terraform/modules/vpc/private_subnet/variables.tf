variable "aws_az" {
    type =  string
    default = "us-east-1b"
}


variable "vpc_cidr_private" {
    type = string
    default = "10.0.12.0/24"
}


variable "roman_vpc_id" {
    type = string
}


variable "nat_id" {
    type = string
}
