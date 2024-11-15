variable "vpc_id" { 
    type = string
}

variable "object" {
    type = object({
      name = string
      adresses = list(string)
    })
    default = {
      name = "sg_group"
      adresses = ["178.127.202.237/32"]
    }
}   