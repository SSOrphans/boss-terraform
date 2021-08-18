variable "tags" {
  type        = map(string)
  description = "Key/Value tags for security group"
}

variable "sg_ingress_traffic" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default     = {}
  description = "Allowed traffic for security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for security group"
}
