module "vpc" {
  source = "../../modules/vpc"

  vpc_info = {
    cidr_block = "10.0.0.0/16"
    tag_name   = "ssor-vpc"
  }

  igw_info = {
    route_cidr_block = "0.0.0.0/0"
    tag_name         = "ssor-igw"
  }

  public_subnets = {
    public_sub1 = {
      cidr_block               = "10.0.1.0/24"
      map_public_ip_on_launch  = true
      # availability_zone        = "us-east-2a"
      availability_zone_suffix = "a"
      tag_name                 = "ssor-sub-public1"
    },
    public_sub2 = {
      cidr_block               = "10.0.2.0/24"
      map_public_ip_on_launch  = true
      # availability_zone        = "us-east-2b"
      availability_zone_suffix = "b"
      tag_name                 = "ssor-sub-public2"
    }
  }

  private_subnets = {
    private_sub1 = {
      cidr_block               = "10.0.3.0/24"
      # availability_zone        = "us-east-2c"
      availability_zone_suffix = "c"
      tag_name                 = "ssor-sub-private1"
    }
  }

  rt_tag_names = {
    private_rt_name = "ssor-rt-private"
    public_rt_name  = "ssor-rt-public"
  }

  security_group_info = {
    sg_name        = "ssor-sg"
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
    },
    microservices = {
      description = "ELB to microservices"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_block  = "10.0.0.0/16"
    }
  }

  eip_name = "ssor-nat-eip"

  nat_gw_info = {
    route_cidr_block = "0.0.0.0/0"
    nat_gw_tag       = "ssor-nat-gw"
    public_sub_tag   = "ssor-sub-public1"
  }

  region = var.region
}
