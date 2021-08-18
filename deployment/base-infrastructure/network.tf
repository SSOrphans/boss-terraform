module "vpc" {
  source = "../../modules/vpc"

  cidr_block = "10.0.0.0/16"
  tags = {
    Name                                     = "ssor-vpc"
    "kubernetes.io/cluster/ssor-eks-cluster" = "shared"
  }
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id = module.vpc.id

  subnets = {
    public_sub1 = {
      cidr_block               = "10.0.1.0/24"
      map_public_ip_on_launch  = true
      availability_zone_suffix = "a"
      tags = {
        Name                                     = "ssor-sub-public1"
        "kubernetes.io/cluster/ssor-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
      }
    },
    public_sub2 = {
      cidr_block               = "10.0.2.0/24"
      map_public_ip_on_launch  = true
      availability_zone_suffix = "b"
      tags = {
        Name                                     = "ssor-sub-public2"
        "kubernetes.io/cluster/ssor-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
      }
    },
    private_sub1 = {
      cidr_block               = "10.0.3.0/24"
      map_public_ip_on_launch  = false
      availability_zone_suffix = "a"
      tags = {
        Name                                     = "ssor-sub-private1"
        "kubernetes.io/cluster/ssor-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb"        = 1
      }
    },
    private_sub2 = {
      cidr_block               = "10.0.4.0/24"
      map_public_ip_on_launch  = false
      availability_zone_suffix = "b"
      tags = {
        Name                                     = "ssor-sub-private2"
        "kubernetes.io/cluster/ssor-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb"        = 1
      }
    }
  }
}

module "security_group" {
  source = "../../modules/sg"

  vpc_id = module.vpc.id

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

  tags = {
    Name = "ssor-sg"
  }
}

module "nat" {
  source = "../../modules/nat"

  vpc_id             = module.vpc.id
  public_subnets_id  = module.subnet.public_subnets_id
  private_subnets_id = module.subnet.private_subnets_id

  nat_gw_route_cidr_block    = "0.0.0.0/0"
  nat_tag_name_prefix        = "ssor-nat"
  eip_tag_name_prefix        = "ssor-eip"
  private_rt_tag_name_prefix = "ssor-private-rt"
}

module "igw" {
  source = "../../modules/igw"

  vpc_id            = module.vpc.id
  public_subnets_id = module.subnet.public_subnets_id

  igw_route_cidr_block = "0.0.0.0/0"

  igw_tags = {
    Name = "ssor-igw"
  }
  public_rt_tags = {
    Name = "ssor-public-rt"
  }
}
