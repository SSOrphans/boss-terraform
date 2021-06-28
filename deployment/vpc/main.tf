module "vpc" {
  source              = "../../modules/vpc"
  vpc_info            = var.vpc_info
  igw_info            = var.igw_info
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  rt_tag_names        = var.rt_tag_names
  security_group_info = var.security_group_info
  sg_ingress_traffic  = var.sg_ingress_traffic
}