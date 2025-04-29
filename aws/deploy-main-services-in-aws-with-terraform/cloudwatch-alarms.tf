resource "aws_cloudwatch_metric_alarm" "rds_nodepostgreslocal_cpu" {
  alarm_name             = "RDS_NODEPOSTRESLOCAL_CPU"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  evaluation_periods     = "4"
  metric_name            = "CPUUtilization"
  namespace              = "AWS/RDS"
  period                 = "300"
  statistic              = "Average"
  threshold              = "80"
  actions_enabled        = "true"
  alarm_actions          = [aws_sns_topic.devops.arn]

  dimensions = {
    DBInstanceIdentifier = "nodepostgreslocal"
  }
}
