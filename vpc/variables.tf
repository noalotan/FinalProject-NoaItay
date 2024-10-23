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
