variable "vpc_id" {
  type        = string
  description = "VPC ID for route table and IGW"
}

variable "public_subnets_id" {
  type        = list(string)
  description = "Public subnets for route table"
}

variable "igw_route_cidr_block" {
  type        = string
  description = "IGW CIDR block for route table"
}

variable "igw_tags" {
  type        = map(string)
  description = "Key/Value tag for IGW"
}

variable "public_rt_tags" {
  type        = map(string)
  description = "Key/Value tag for route table"
}
