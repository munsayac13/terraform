resource "aws_cloudwatch_log_group" "mylocalone_log_group" {
  name = "mylocalone_log_group"
  retention_in_days = 10  
}

resource "aws_cloudwatch_log_stream" "mylocalone_log_stream" {
  name           = "mylocalone_log_stream"
  log_group_name = aws_cloudwatch_log_group.mylocalone_log_group.name
}

resource "aws_cloudwatch_log_group" "mylocalone_firehose_log_group" {
  name = "/aws/kinesisfirehose/mylocalone_firehose_delivery"
  tags = {
    Name = "mylocalone_firehose_delivery"
  }
}

resource "aws_cloudwatch_log_stream" "mylocalone_firehose_log_stream" {
  name = "/aws/kinesisfirehose/mylocalone_firehose_stream"
  log_group_name = aws_cloudwatch_log_group.mylocalone_firehose_log_group.name
}
