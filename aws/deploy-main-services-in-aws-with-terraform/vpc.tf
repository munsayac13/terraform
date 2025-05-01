# VPC
resource "aws_vpc" "mylocalone" {
  cidr_block = "10.0.0.0/8"
  enable_dns_support = true
  enable_dns_hostnames = true
}
