resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = var.redis_subnet_group_name
  subnet_ids = data.terraform_remote_state.static.outputs.private_subnets
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
