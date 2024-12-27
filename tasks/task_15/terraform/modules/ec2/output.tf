output "ubuntu_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "amazon_id" {
  value = aws_instance.amazon.public_ip
}