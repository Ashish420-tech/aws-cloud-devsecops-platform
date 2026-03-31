variable "public_subnet_id" {
  description = "Public subnet for bastion host"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group for bastion"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
variable "private_subnet_id" {
  description = "Private subnet for app instance"
  type        = string
}

variable "app_sg_id" {
  description = "Security group for application"
  type        = string
}
variable "instance_profile_name" {
  description = "IAM instance profile for EC2"
  type        = string
}
