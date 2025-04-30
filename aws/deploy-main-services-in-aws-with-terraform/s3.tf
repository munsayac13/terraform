resource "aws_s3_bucket" "myterraformbucket" {
  bucket = "myterraformbucket"
  acl    = "private"
  tags = {
    Name = "myterraformbucket"
  }
}

resource "aws_s3_bucket" "mylocalone_cloudtrail" {
  bucket = "mylocalone_cloudtrail"
  acl    = "private"
  lifecycle_rule {
    id      = "remove_after_10_days"
    enabled = true
    expiration {
      days = 10
    }
  }
  tags = {
    Name = "mylocalone_cloudtrail
  }
}

resource "aws_s3_bucket" "samplebucketone_enterprise_com" {
  bucket = "samplebucketone_enterprise_com"
  acl    = "public-read"
  policy = <<IAMPOLICY 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::samplebucketone_enterprise_com/*"
        },
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::123456789100:role/devops",
                    "arn:aws:iam::123456789100:user/devops"
                ]
            },
            "Action": [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::samplebucketone_enterprise_com/*",
                "arn:aws:s3:::samplebucketone_enterprise_com"
            ]
        }
    ]      
}
IAMPOLICY

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["https://*.enterprise.com/"]
  }

  tags = {
    Name = "samplebucketone"
  }
}


resource "aws_s3_bucket" "samplebuckettwo_enterprise_com" {
  bucket = "samplebuckettwo_enterprise_com"
  acl    = "public-read"
  lifecycle_rule {
    id      = "remove_after_90_days"
    enabled = true
    expiration {
      days = 90
    }
  }
  policy = <<IAMPOLICY 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::samplebuckettwo_enterprise_com/*"
        },
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::123456789100:role/devops",
                    "arn:aws:iam::123456789100:user/devops"
                ]
            },
            "Action": [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::samplebuckettwo_enterprise_com/*",
                "arn:aws:s3:::samplebuckettwo_enterprise_com"
            ]
        }
    ]      
}
IAMPOLICY

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["https://*.enterprise.com/"]
  }

  tags = {
    Name = "samplebuckettwo"
  }

}

# Different Way 
resource "aws_s3_bucket" "mylocalone_kinesis" {
  bucket = "mylocalone_kinesis_stream"
}

resource "aws_s3_bucket_acl" "mylocalone_kinesis_bucket_acl" {
  bucket = aws_s3_bucket.mylocalone_kinesis.id
  acl    = "private"
}
