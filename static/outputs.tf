# vpc outputs

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





# roles outputs

output "eks_cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "The ARN of the EKS node IAM role"
  value       = aws_iam_role.eks_node_role.arn
}


# db outputs

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.mydb_subnet_group.name
}

output "db_instance_identifier" {
  description = "The identifier of the DB instance"
  value       = aws_db_instance.mydb.identifier
}

output "db_instance_endpoint" {
  description = "The endpoint address of the DB instance"
  value       = aws_db_instance.mydb.address
}

output "db_instance_arn" {
  description = "The ARN of the DB instance"
  value       = aws_db_instance.mydb.arn
}

