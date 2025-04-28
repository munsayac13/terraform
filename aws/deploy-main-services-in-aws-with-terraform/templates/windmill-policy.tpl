{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowWindmillECRUpload",
            "Effect": "Allow",
            "Action": [
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:GetAuthorizationToken",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:CreateTags",
                "ec2:DeleteTags",
                "s3:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
