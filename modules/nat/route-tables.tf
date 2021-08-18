resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  count  = length(var.private_subnets_id)
  route {
    cidr_block     = var.nat_gw_route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name = "${var.private_rt_tag_name_prefix}-${count.index}"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(var.private_subnets_id)
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = var.private_subnets_id[count.index]
}
