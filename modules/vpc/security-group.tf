resource "aws_security_group" "security_group" {
  name        = var.security_group_info.sg_name
  description = var.security_group_info.sg_description
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.sg_ingress_traffic
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["cidr_block"]]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_info.sg_name
  }
}