output "instance_profile_name" {
  description = "IAM Instance Profile for EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}
output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}
output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = aws_iam_role.eks_node_role.arn
}
