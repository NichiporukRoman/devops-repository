variable "ami_ubuntu" {
    default = "ami-0866a3c8686eaeeba"
    type = string
    sensitive = false
}

variable "ami_amazon" {
    default = "ami-0453ec754f44f9a4a"
    type = string
    sensitive = false
}

variable "type" {
    default = "t2.nano"
    type = string
    sensitive = false
}

variable "keypair" {
    default = "noire"
    type = string
    sensitive = false
}

variable "security_group_id" {
    type = string
    sensitive = false
}   

variable "subnet_id" {
    default = "subnet-00db06b9860d2e1a1"
    type = string
    sensitive = false
  
}