output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
    value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnets_id" {
    value = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "alb_subnets" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}