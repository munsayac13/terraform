data "aws_subnet" "mylocalone_subnet_private_a" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-private-1a"]
  }
}

data "aws_subnet" "mylocalone_subnet_public_b" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-public-1a"]
  }
}

data "aws_subnet" "mylocalone_subnet_private_b" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-private-1b"]
  }
}

data "aws_subnet" "mylocalone_subnet_public_b" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-public-1b"]
  }
}

data "aws_s3_bucket" "mylocalone_terraform_bucket" {
  bucket = "mylocaloneterraformbucket"
}

data "aws_iam_policy_document" "nodepostgreslocal_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

data "archive_file" "lambda_package" {
  type = "zip"
  source_file = "index.js"
  output_path = "index.zip"
}

data "aws_route53_zone" "mylocalone_domain" {
  name = "cmenterprise.com"
  private_zone = false
}
