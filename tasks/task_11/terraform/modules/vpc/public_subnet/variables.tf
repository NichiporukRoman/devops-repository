variable "aws_az" {
    type =  string
    default = "us-east-1a"
}


variable "vpc_cidr_public" {
    type = string
    default = "10.0.11.0/24"
}


variable "vpc_cidr_private" {
    type = string
    default = "10.0.12.0/24"
}


variable "public_rt_id" {
    type = string
}


variable "roman_vpc_id" {
    type = string
}


variable "nat_eip_id" {
    type = string
}
