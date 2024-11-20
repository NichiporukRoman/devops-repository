variable "aws_region" {
  default = "us-east-1a"
  sensitive = true
}

variable "secret" {
  type = string
  default = "password"
  sensitive = true
}