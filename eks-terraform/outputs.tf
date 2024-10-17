output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_security_group_id" {
  description = "The security group ID for EKS nodes"
  value       = aws_security_group.eks_nodes.id
}

# output "nat_gateway_id" {
#  description = "The ID of the NAT Gateway (if enabled)"
#  value       = module.vpc.enable_nat_gateway ? module.vpc.nat_gateway_id : null
#}
