vpc_data_inputs = {
  vpc_tag           = "boss-vpc"
  alb_name          = "boss-terraform-alb"
  alb_listener_port = 80
  subnet_tag        = "boss-sub-private1"
  sg_tag            = "boss-sg"
}