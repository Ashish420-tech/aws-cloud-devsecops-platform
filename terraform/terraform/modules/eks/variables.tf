variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for EKS cluster"
  type        = list(string)
}
variable "node_role_arn" {
  description = "IAM role for EKS worker nodes"
  type        = string
}
