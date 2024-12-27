variable "ami_ubuntu" {
    default = "ami-0866a3c8686eaeeba"
    type = string
    sensitive = false
}

variable "vpc_id" { 
    default = "vpc-026275a058dbb5e92"
    type = string
    sensitive = false
}

variable "type" {
    default = "t2.medium"
    type = string
    sensitive = false
}

variable "keypair" {
    default = "noire"
    type = string
    sensitive = false
}

variable "subnet_id" {
    default = "subnet-00db06b9860d2e1a1"
    type = string
    sensitive = false
  
}

variable "object" {
    type = object({
      name = string
      adresses = list(string)
    })
    default = {
      name = "sg_group"
      adresses = ["0.0.0.0/0"]
    }
    sensitive = false
}   