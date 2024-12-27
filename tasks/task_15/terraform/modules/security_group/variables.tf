variable "vpc_id" { 
    default = "vpc-026275a058dbb5e92"
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