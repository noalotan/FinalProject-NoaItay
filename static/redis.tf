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

  tags = merge(local.billing_tags, {
    Name = "elasticache-sg-${local.resource_name}"  # Adding a specific name tag
  })
}


resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = var.redis_subnet_group_name
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = var.redis_replication_group_id
  description                   = "Redis replication group"
  node_type                     = "cache.t2.micro"
  num_node_groups               = 1
  replicas_per_node_group       = 0
  parameter_group_name          = "default.redis7"
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids            = [aws_security_group.elasticache_sg.id]
  automatic_failover_enabled    = false
  engine                        = "redis"
  engine_version                = "7.1"
  tags                          = local.billing_tags
}
