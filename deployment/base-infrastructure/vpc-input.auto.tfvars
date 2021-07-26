vpc_info = {
  cidr_block = "10.0.0.0/16"
  tag_name   = "boss-vpc"
}

igw_info = {
  route_cidr_block = "0.0.0.0/0"
  tag_name         = "boss-igw"
}

public_subnets = {
  public_sub1 = {
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
    # availability_zone       = "us-east-2a"
    availability_zone_suffix = "a"
    tag_name                 = "boss-sub-public1"
  },
  public_sub2 = {
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = true
    # availability_zone       = "us-east-2b"
    availability_zone_suffix = "b"
    tag_name                 = "boss-sub-public2"
  }
}

private_subnets = {
  private_sub1 = {
    cidr_block = "10.0.3.0/24"
    tag_name   = "boss-sub-private1"
  }
}

rt_tag_names = {
  private_rt_name = "boss-rt-private"
  public_rt_name  = "boss-rt-public"
}

security_group_info = {
  sg_name        = "boss-sg"
  sg_description = "Secruity group for BoSS network"
}

sg_ingress_traffic = {
  http = {
    description = "Allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  https = {
    description = "Allow https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  }
}

eip_name = "boss-nat-eip"

nat_gw_subnet_tag = "boss-sub-public1"
