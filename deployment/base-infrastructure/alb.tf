module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name               = "ssor-alb"
  load_balancer_type = "application"

  vpc_id          = module.vpc.id
  subnets         = module.subnet.public_subnets_id
  security_groups = [module.security_group.id]

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
}
