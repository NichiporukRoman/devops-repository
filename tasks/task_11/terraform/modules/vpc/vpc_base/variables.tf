variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}


variable "vpc_cidr_public" {
    type = string
    default = "10.0.11.0/24"
}


variable "vpc_cidr_private" {
    type = string
    default = "10.0.12.0/24"
}
