module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
module "security" {
  source = "../../modules/security"

  vpc_id = module.vpc.vpc_id
}
