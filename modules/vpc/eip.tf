resource "aws_eip" "eip" {
  tags = {
    Name = "${var.eip_name}${count.index}"
  }
  count = length(aws_subnet.private_subnets)
}
