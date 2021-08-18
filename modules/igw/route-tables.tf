resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.igw_route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.public_rt_tags
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnets_id)
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = var.public_subnets_id[count.index]
}
