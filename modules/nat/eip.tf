resource "aws_eip" "eip" {
  count = length(var.private_subnets_id)
  tags = {
    Name = "${var.eip_tag_name_prefix}-${count.index}"
  }
}
