output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "availability_zones" {
  description = "List of availability zones"
  value       = module.vpc.azs
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.cidr
}
