resource "aws_iam_policy" "mylocalone_cloudtrail" {
  name            = "mylocalone_cloudtrail"
  path            = "/"

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::mylocalone_cloudtrail"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::mylocalone_cloudtrail/*"
        }
    ]
}
  )
}


resource "aws_iam_policy" "thirdparty_vendor_cloudtrail" {
  name            = "thirdparty_vendor_cloudtrail"
  path            = "/"

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sns:*",
            "Resource": [
                "arn:aws:sns:us-east-1:123456789100:thirdparty_vendor_cloudtrail"
            ]
        }
    ]
}
  )
}

resource "aws_iam_policy" "nodepostgreslocal_load_from_s3" {
  name                         = "nodepostgreslocal_load_from_s3"
  path                         = "/"
  description                  = "NodePostgresLocal Load from S3 Bucket"

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "LoadFromS3",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::*_enterprise_com",
                "arn:aws:s3:::*_enterprise_com/*"
            ]
        }
    ]
}
  )
}

resource "aws_iam_role" "nodepostgreslocal_load_from_s3" {
  name                = "nodepostgreslocal_load_from_s3"
  assume_role_policy  = data.aws_iam_policy_document.nodepostgreslocal_iam_policy_document.json
  managed_policy_arns = [
    aws_iam_policy.nodepostgreslocal_load_from_s3.arn,
    "arn:aws:iam::aws:policy/service-role/AmazonRDSDirectoryServiceAccess",
    "arn:aws:iam::aws:policy/service-role/RDSCloudHsmAuthorizationRole"
  ]
}
