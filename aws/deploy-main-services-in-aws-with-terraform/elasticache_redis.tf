resource "aws_elasticache_cluster" "noderedislocal" {
  cluster_id         = "noderedislocal"
  engine             = "redis"
  engine_version     = "7.2"
  node_type          = "cache.m4.large"
  num_cache_nodes    = 1
  port               = 6379
  
  # Send logs to Cloudwatch
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.mylocalone_log_group.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}

resource "aws_elasticache_replication_group" "noderedislocal" {
  automatic_failover_enabled    = true
  engine                        = "redis"
  availability_zones            = ["us-east-1a","us-east-1b"]
  replication_group_id          = "noderedislocal"
  replication_group_description = "noderedislocal"
  node_type                     = "cache.m4.large"
  number_cache_clusters         = 3
  parameter_group_name          = aws_elasticache_parameter_group.noderedislocal_parameter_group.name
  security_group_ids            = [aws_security_group.default_base.id]
  engine_version                = "7.2"
  port                          = 6379
  subnet_group_name             = aws_elasticache_subnet_group.noderedislocal_subnet_group.name

  lifecycle {
    ignore_changes = [ tags["Name"] ]
  }
}

resource "aws_elasticache_parameter_group" "noderedislocal_parameter_group" {
  name               = "noderedislocal"
  family             = "redis7.2"

  parameter {
    name             = "notify-keyspace-events"
    value            = "devops"
  }
}

resource "aws_elasticcache_subnet_group" "noderedislocal_subnet_group" {
  subnet_ids = [
    data.aws_subnet.mylocalone_subnet_private_a.id
    data.aws_subnet.mylocalone_subnet_private_b.id
  ]
}
