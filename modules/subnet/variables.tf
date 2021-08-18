variable "subnets" {
  type = map(object({
    cidr_block               = string
    map_public_ip_on_launch  = bool
    availability_zone_suffix = string
    tags                     = map(string)
  }))
  description = "Subnets for vpc"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for subnets"
}
