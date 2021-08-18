variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
  description = "CIDR block for VPC"
}

variable "tags" {
  type = map(string)
  description = "Key/Value tags for VPC"
}