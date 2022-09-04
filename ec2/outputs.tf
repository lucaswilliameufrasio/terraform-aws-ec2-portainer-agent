output "ec2_public_dns" {
  value = aws_instance.uai.public_dns
  depends_on = [
    aws_instance.uai
  ]
}

output "ec2_public_ip" {
  value = aws_eip.eip.public_ip
}