data "aws_vpc" "this" {
  tags = {
    Name = var.vpc_data_inputs.vpc_tag
  }
}

data "aws_alb" "this" {
  name = var.vpc_data_inputs.alb_name
}

data "aws_alb_listener" "this" {
  load_balancer_arn = data.aws_alb.this.arn
  port = var.vpc_data_inputs.alb_listener_port
}

data "aws_subnet" "this" {
  tags = {
    Name = var.vpc_data_inputs.subnet_tag
  }
}

data "aws_security_group" "this" {
  tags = {
    Name = var.vpc_data_inputs.sg_tag
  }
}