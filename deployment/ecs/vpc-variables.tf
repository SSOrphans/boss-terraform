variable "vpc_data_inputs" {
  type = object({
    vpc_tag           = string
    alb_name          = string
    alb_listener_port = number
    subnet_tag        = string
    sg_tag            = string
  })
  description = "Tag names and listener port to filter data resource blocks"
}

variable "region" {
  type        = string
  description = "Region inputs defined at ./region-inputs/"
}
