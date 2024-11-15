variable "ami_id" {
    type = string
    default = "ami-0866a3c8686eaeeba"
}


variable "instance_type" {
    type = string
    default = "t2.nano"
}


variable "keypair" {
    type = string
    default = "noire"
}


variable "subnet_id" {
    type = string
}


variable "security_group_id" {
    type = string
}
