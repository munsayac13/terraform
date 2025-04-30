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

##########

resource "aws_iam_role" "mylocalone_firehose_delivery_stream" {
  name = "mylocalone_firehose_delivery_stream"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF 
}

resource "aws_iam_policy" "mylocalone_firehose_delivery_stream_to_s3" {
  name_prefix = "mylocalone_stream_"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "s3:AbortMultipartUpload",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:PutObject"
        ],
        "Resource": [
            "${aws_s3_bucket.mylocalone_kinesis.arn}",
            "${aws_s3_bucket.mylocalone_kinesis.arn}/*"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "mylocalone_firehose_delivery_stream_to_s3" {
  role       = aws_iam_role.mylocalone_firehose_delivery_stream.name
  policy_arn = aws_iam_policy.mylocalone_firehose_delivery_stream_to_s3.arn
}

resource "aws_iam_policy" "mylocalone_firehose_put_record" {
  name_prefix = "mylocalone_put_record_stream_"
  policy      = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "firehose:PutRecord",
                "firehose:PutRecordBatch"
            ],
            "Resource": [
                "${aws_kinesis_firehose_delivery_stream.mylocalone_firehose_delivery_stream_to_s3.arn}"            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "mylocalone_firehose_put_record" {
  role       = aws_iam_role.mylocalone_firehouse_delivery_stream.name
  policy_arn = aws_iam_policy.mylocalone_firehose_put_record.arn
}

resource "aws_iam_policy" "mylocalone_firehose_cloudwatch" {
  name_prefix = "mycloneone_firehouse_cloudwatch_"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": [
            "${aws_cloudwatch_log_group.mylocalone_firehose_log_group.arn}"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "mylocalone_firehose_cloudwatch" {
  role       = aws_iam_role.mylocalone_firehouse_delivery_stream.name
  policy_arn = aws_iam_policy.mylocalone_firehouse_cloudwatch.arn
}



resource "aws_iam_policy" "mylocalone_kinesis_firehose" {
  name_prefix = "mylocalone_kinesis_firehose_"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
            "kinesis:DescribeStream",
            "kinesis:GetShardIterator",
            "kinesis:GetRecords",
            "kinesis:ListShards"
        ],
        "Resource": "${aws_kinesis_stream.mylocalone_kinesis_stream.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "mylocalone_kinesis_firehose" {
  role       = aws_iam_role.mylocalone_kinesis_stream.name
  policy_arn = aws_iam_policy.mylocalone_kinesis_firehose.arn
}

