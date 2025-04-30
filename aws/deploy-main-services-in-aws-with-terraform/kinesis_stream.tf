resource "aws_kinsesis_stream" "mylocalone_kinesis_stream" {
  name             = "mylocalone_kinsesis_stream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
  tags = {
    Name = "mylocalone_kinsesis_stream"
  }
}
