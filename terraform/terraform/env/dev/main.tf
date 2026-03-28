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

module "ec2" {
  source = "../../modules/ec2"

  public_subnet_id  = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.private_subnets[0]

  bastion_sg_id = module.security.bastion_sg_id
  app_sg_id     = module.security.app_sg_id

  key_name = "devsecops-key"
}
