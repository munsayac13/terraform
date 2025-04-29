resource "aws_cloudtrail" "mylocalone_cloudtrail" {
  name            = "mylocalone-cloudtrail"
  s3_bucket_name  = aws_s3_bucket.mylocalone_cloudtrail.id
}
