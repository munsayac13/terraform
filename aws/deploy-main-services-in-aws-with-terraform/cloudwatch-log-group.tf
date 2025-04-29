resource "aws_cloudwatch_log_group" "mylocalone_log_group" {
  name = "mylocalone_log_group"
  retention_in_days = 10  
}

resource "aws_cloudwatch_log_stream" "mylocalone_log_stream" {
  name           = "mylocalone_log_stream"
  log_group_name = aws_cloudwatch_log_group.mylocalone_log_group.name
}
