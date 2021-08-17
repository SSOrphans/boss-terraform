resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.igw_info.route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.rt_tag_names.public_rt_name
  }
}

resource "aws_route_table_association" "public_rt_association" {
  for_each       = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = each.value["id"]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  count  = length(aws_subnet.private_subnets)
  route {
    cidr_block     = var.nat_gw_info.route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name = "${var.rt_tag_names.private_rt_name}${count.index}"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnets)
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = element([for subnet in aws_subnet.private_subnets : subnet.id], count.index)
}
