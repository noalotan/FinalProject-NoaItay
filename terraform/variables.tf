variable "region" {
  description = "Value of the region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "Value of the ami for the EC2 instance"
  type        = string
  default     = "ami-0656f17367d922a54"
}

variable "instance_type" {
  description = "Value of the instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Value of the subnet id for the EC2 instance"
  type        = string
  default     = "subnet_id"
}

variable "security_groups" {
  description = "Value of the security groups for the EC2 instance"
  type        = string
  default     = "security_groups"
}

variable "key_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string
  default     = "your-key-pair-name"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
