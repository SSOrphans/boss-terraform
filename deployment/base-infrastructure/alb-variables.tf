variable "alb_name" {
  type = string
  description = "Name of the application load balancer."
}

variable "target_group_prefix" {
  type = string
  description = "Prefix for the name of the load balancer"
}

variable "certificate_arn" {
  type = string
  description = "ARN of the SSL Certificate"
}



