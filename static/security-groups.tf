resource "aws_security_group" "elasticache_sg" {
  name        = "elasticache-sg-${local.resource_name}"
  description = "Security group for ElastiCache"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust to your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.billing_tags
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-${local.resource_name}"
  description = "Security group for RDS"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust to your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.billing_tags
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-sg-${local.resource_name}"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = ["sg-00517b0aa62592c6d"]  # Allow traffic from EKS SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as necessary
  }

  tags = local.billing_tags
}
