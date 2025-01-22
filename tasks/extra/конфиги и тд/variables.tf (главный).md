```
variable "ami" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the servers"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ssh_ip" {
  description = "IP allowed for SSH access"
  type        = string
}

variable "allowed_db_cidr_block" {
  description = "CIDR блок для доступа к базе данных"
  type        = string
}
```