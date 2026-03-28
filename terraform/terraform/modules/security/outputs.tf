output "bastion_sg_id" {
  description = "Security Group ID for Bastion Host"
  value       = aws_security_group.bastion_sg.id
}

output "app_sg_id" {
  description = "Security Group ID for Application"
  value       = aws_security_group.app_sg.id
}
