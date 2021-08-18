variable "vpc_id" {
  type        = string
  description = "VPC ID for route tables and NAT"
}

variable "public_subnets_id" {
  type        = list(string)
  description = "Public subnets to assign NAT"
}

variable "private_subnets_id" {
  type        = list(string)
  description = "Private subnets for route tables"
}
variable "nat_gw_route_cidr_block" {
  type        = string
  description = "NAT CIDR block for route tables"
}
variable "nat_tag_name_prefix" {
  type        = string
  description = "Name tag for NAT"
}

variable "eip_tag_name_prefix" {
  type        = string
  description = "Name tag for EIP"
}

variable "private_rt_tag_name_prefix" {
  type        = string
  description = "Name tag for private route table"
}
