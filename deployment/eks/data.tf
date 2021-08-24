data "aws_region" "current" {}

data "aws_vpc" "selected" {
  tags = {
    Name = "ssor-vpc"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name = "map-public-ip-on-launch"
    values = ["false"]
  }
}

data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = "ssor-sg"
  }
}