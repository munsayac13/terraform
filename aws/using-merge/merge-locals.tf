locals {
  common_tags = {
    "cost_center" = "devops"
    "environment" = "staging"
  }
  aws_region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-0abcdef1234567890"
  tags = merge(local.common_tags, { name = "example-instance" })
}
