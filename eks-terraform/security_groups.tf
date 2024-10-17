resource "aws_security_group" "eks_nodes" {
  name        = "eks-sg-${local.resource_name}"
  description = "Allow traffic to EKS nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = local.billing_tags
}