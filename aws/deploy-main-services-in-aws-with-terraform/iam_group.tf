resource "aws_iam_group" "mylocalone_cloudtrail" {
  name            = "mylocalonecloudtrail"
}

resource "aws_iam_group_policy_attachment" "mylocalone_cloudtrail" {
  group           = aws_iam_group.mylocalone_cloudtrail.name
  policy_arn      = aws_iam_policy.mylocalone_cloudtrail.arn
}

resource "aws_iam_group_policy_attachment" "AmazonSNSSumologic" {
  group           = aws_iam_group.cloudtrail.name
  policy_arn      = aws_iam_policy.AmazonSNSSumologic.arn
}
