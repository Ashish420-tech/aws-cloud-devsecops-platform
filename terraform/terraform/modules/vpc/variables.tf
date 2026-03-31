variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}
