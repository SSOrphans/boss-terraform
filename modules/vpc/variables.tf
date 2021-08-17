variable "vpc_info" {
  type = object({
    cidr_block = string
    tag_name   = string
  })
  description = "Tag name and CIDR block for VPC"
}

variable "igw_info" {
  type = object({
    route_cidr_block = string
    tag_name         = string
  })
  description = "Tag name and CIDR for route to igw"
}

variable "public_subnets" {
  type = map(object({
    cidr_block               = string
    map_public_ip_on_launch  = bool
    availability_zone_suffix = string
    tag_name                 = string
  }))
  description = "Public subnets for vpc"
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    availability_zone_suffix = string
    tag_name   = string
  }))
  description = "Private subnets for vpc"
}

variable "rt_tag_names" {
  type = object({
    private_rt_name = string
    public_rt_name  = string
  })
  description = "Tag name for route tables"
}

variable "security_group_info" {
  type = object({
    sg_name        = string
    sg_description = string
  })
  description = "Security group name and description"
}

variable "sg_ingress_traffic" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  description = "Allowed traffic for security group"
}

variable "eip_name" {
  type        = string
  description = "Tag name for the EIP and "
}

variable "nat_gw_info" {
  type = object({
    route_cidr_block = string
    nat_gw_tag       = string
    public_sub_tag   = string
  })
  description = "Tag name of the nat gateway and public subnet to place the nat gateway in"
}

variable "region" {
  type        = string
  description = "Region inputs defined at ./region-inputs/"
}
