resource "aws_subnet" "subnets" {
  count                   = length(var.subnets) > 0 ? length(var.subnets) : 0
  vpc_id                  = var.vpc_id
  cidr_block              = element([for subnet in var.subnets : subnet.cidr_block], count.index)
  map_public_ip_on_launch = element([for subnet in var.subnets : subnet.map_public_ip_on_launch], count.index)
  availability_zone       = "${data.aws_region.current.name}${element([for subnet in var.subnets : subnet.availability_zone_suffix], count.index)}"
  tags                    = element([for subnet in var.subnets : subnet.tags], count.index)
}
