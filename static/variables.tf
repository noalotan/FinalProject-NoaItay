# general vars

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "resource_name" {
  description = "General resource name"
  type        = string
  default     = "noa-itay-Dev"
}

variable "billing_tags" {
  description = "Tags for billing"
  type        = map(string)
  default     = {
    Project = "TeamA"
  }
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-01069a335615ca3e2"
}

variable "private_subnets" {
  description = "List of Private subnets"
  type        = list(string)
  default     = [
  "subnet-0f9be926b8c4a4e7c",
  "subnet-006819ee8aabc9934",
  "subnet-0aa5bd8a45cffc131",
]
}

variable "public_subnets" {
  description = "List of Private subnets"
  type        = list(string)
  default     = [
  "subnet-0843c8d7bd8f1f063",
  "subnet-015796b3041bd37e8",
  "subnet-0cb8ffdcc5ade255a",
]
}



# postgresql db vars

variable "db_name" {
  description = "The name of the PostgreSQL database instance"
  default     = "itayandnoa-dev"
}

variable "db_user" {
  description = "The database admin user name"
  default     = "statuspage"
}

variable "db_password" {
  description = "The database admin password"
  default     = "itayandnoa"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  default     = "noa-itay-db-subnet-group-dev"
}



# redis vars

variable "redis_replication_group_id" {
  description = "The ID of the ElastiCache Redis cluster"
  default     = "noa-itay-redis-cache-dev"
}

variable "redis_subnet_group_name" {
  description = "The name of the ElastiCache subnet group"
  default     = "noa-itay-redis-subnet-group-dev"
}
