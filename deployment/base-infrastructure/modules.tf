module "s3" {
  source            = "../../modules/s3"
  bucket_info       = var.bucket_info
  bucket_static_web = var.bucket_static_web
  bucket_policy     = var.bucket_policy
  bucket_cors       = var.bucket_cors
  bucket_acl        = var.bucket_acl
}

module "vpc" {
  source              = "../../modules/vpc"
  vpc_info            = var.vpc_info
  igw_info            = var.igw_info
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  rt_tag_names        = var.rt_tag_names
  security_group_info = var.security_group_info
  sg_ingress_traffic  = var.sg_ingress_traffic
  eip                 = var.eip
}

module "ecr" {
  source         = "../../modules/ecr"
  ecr_repo_names = var.ecr_repo_names
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.alb_name

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets_id
  security_groups = [module.vpc.security_group_id]

  #### Temporary while setting up SSL ####
  target_groups = [
    {
      name_prefix      = var.target_group_prefix
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  #### End Temporary ####

  ### To be used later when SSL is created
  # target_groups = [
  #   {
  #     name_prefix      = "pref-"
  #     backend_protocol = "HTTPS"
  #     backend_port     = 443
  #     target_type      = "instance"
  #   }
  # ]

  # https_listeners = [
  #   {
  #     port                 = 443
  #     protocol             = "HTTPS"
  #     certificate_arn      = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  #     target_group_index   = 0
  #   }
  # ]

  # http_tcp_listeners = [
  #   {
  #     port        = 80
  #     protocol    = "HTTP"
  #     action_type = "redirect"
  #     redirect = {
  #       port        = "443"
  #       protocol    = "HTTPS"
  #       status_code = "HTTP_301"
  #     }
  #   }
  # ]

  tags = {
    Environment = "Test"
  }
}
