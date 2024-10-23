# general vars

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "resource_name" {
  description = "General resource name"
  type        = string
  default     = "noa-itay"
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
  default     = "vpc-0d5cc8a37d7f450f2"
}
variable "private_subnets" {
  description = "List of Private subnets"
  type        = list(string)
  default     = ["subnet-0996935fad4064213, subnet-0f6a890766d8d5ef1"]
}



# postgresql db vars

variable "db_name" {
  description = "The name of the PostgreSQL database instance"
  default     = "itayandnoa"
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
  default     = "noa-itay-db-subnet-group"
}



# redis vars

variable "redis_replication_group_id" {
  description = "The ID of the ElastiCache Redis cluster"
  default     = "noa-itay-redis-cache"
}

variable "redis_subnet_group_name" {
  description = "The name of the ElastiCache subnet group"
  default     = "noa-itay-redis-subnet-group"
}
