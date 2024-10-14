variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "eks-noa-itay-status-page"
}

variable "vpc_name" {
  description = "AWS VPC Name"
  type        = string
  default     = "vpc-noa-itay-status-page"
}

variable "billing_tags" {
  description = "Billing tags to apply to resources"
  type        = map(string)
  default     = {
    Project = "TeamA"
  }
}
