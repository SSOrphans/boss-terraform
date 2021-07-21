resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = one([for subnet in aws_subnet.public_subnets : subnet.id if subnet.tags.Name == "${var.eip.public_sub_tag_name}"])

  tags = {
    Name = "boss-nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}