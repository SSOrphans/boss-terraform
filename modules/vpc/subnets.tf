resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value["cidr_block"]
  map_public_ip_on_launch = each.value["map_public_ip_on_launch"]
  availability_zone       = "${var.aws_region}${each.value["availability_zone_suffix"]}"
  tags = {
    Name = each.value["tag_name"] == "" ? "public-subnet" : each.value["tag_name"]
  }
}

resource "aws_subnet" "private_subnets" {
  for_each   = var.private_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value["cidr_block"]
  tags = {
    Name = each.value["tag_name"] == "" ? "private-subnet" : each.value["tag_name"]
  }
}