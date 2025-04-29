resource "aws_sns_topic" "devops" {
  name      = "devops"
}

resource "aws_sns_topic_subscription" "devops" {
  topic_arn = aws_sns_topic.devops.arn
  protocol  = "email"
  endpoint  = "devops@cmunsayacenterprise.com"
}

resource "aws_sns_topic" "thirdparty_vendor_cloudtrail" {
  name = "thirdparty_vendor_cloudtrail"
}

resource "aws_sns_topic_subscription" "thirdparty_vendor_cloudtrail" {
  topic_arn = aws_sns_topic.thirdparty_vendor_cloudtrail.arn
  protocol  = "https"
  endpoint  = "https://endpointcollection.thirdpartyvendor.com/receiver/v1/event/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
