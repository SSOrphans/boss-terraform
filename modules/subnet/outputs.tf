output "public_subnets_id" {
  value = [for subnet in aws_subnet.subnets : subnet.id if subnet.map_public_ip_on_launch == true]
}

output "private_subnets_id" {
  value = [for subnet in aws_subnet.subnets : subnet.id if subnet.map_public_ip_on_launch == false]
}
