output "ec2_public_dns" {
  value = aws_instance.ec2_instance.public_dns
  depends_on = [
    aws_instance.ec2_instance
  ]
}

output "ec2_public_ip" {
  value = aws_eip.eip.public_ip
}