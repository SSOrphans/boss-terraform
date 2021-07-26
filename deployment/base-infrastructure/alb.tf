module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name               = "ssor-alb"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.alb_subnets
  security_groups = [module.vpc.security_group_id]

  #### Temporary while setting up SSL ####
  target_groups = [
    {
      name             = "ssor-tg"
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
  #     certificate_arn      = ""
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
}
