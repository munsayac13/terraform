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

resource "aws_elasticache_parameter_group" "noderedislocal" {
  name               = "noderedislocal"
  family             = "redis7.2"

  parameter {
    name             = "notify-keyspace-events"
    value            = "devops"
  }
}
