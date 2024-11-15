variable "ami_id" {
    type = string
    default = "ami-0866a3c8686eaeeba"
}


variable "instance_type" {
    type = string
    default = "t2.nano"
}


variable "subnet_id" {
    type = string
}


variable "keypair" {
    type = string
    default = "noire"
}
