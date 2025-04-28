data "aws_subnet" "mylocalone_subnet_private_a" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-private-1a"]
  }
}

data "aws_subnet" "mylocalone_subnet_private_b" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["mylocalone-private-1b"]
  }
}


data "aws_s3_bucket" "mylocalone_terraform_bucket" {
  bucket = "mylocaloneterraformbucket"
}_
