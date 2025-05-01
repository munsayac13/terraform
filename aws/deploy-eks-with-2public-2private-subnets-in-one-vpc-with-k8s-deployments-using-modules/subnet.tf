resource "aws_subnet" "mylocalone_subnet_private_a" {
  vpc_id = local.vpc_id
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "mylocalone-private-a"
  }
}

resource "aws_subnet" "mylocalone_subnet_private_b" {
  vpc_id = local.vpc_id
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "mylocalone-private-b"
  }
}

resource "aws_subnet" "mylocalone_subnet_public_a" {
  vpc_id = local.vpc_id
  cidr_block = "10.11.0.0/16"
  tags = {
    Name = "mylocalone-public-a"
  }
}

resource "aws_subnet" "mylocalone_subnet_public_b" {
  vpc_id = local.vpc_id
  cidr_block = "10.12.0.0/16"
  tags = {
    Name = "mylocalone-public-b"
  }
}
