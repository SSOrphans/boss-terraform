resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = var.public_subnets_id[count.index]
  count         = length(var.private_subnets_id)

  tags = {
    Name = "${var.nat_tag_name_prefix}-${count.index}"
  }
}
