resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = element([for subnet in aws_subnet.public_subnets : subnet.id], count.index)
  count = length(aws_subnet.private_subnets)

  tags = {
    Name = "${var.nat_gw_info.nat_gw_tag}${count.index}"
  }

  depends_on = [aws_internet_gateway.igw]
}
