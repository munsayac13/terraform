terraform {
  backend "s3" {
    bucket         = "myterraformbucket"
    key            = "/root/.aws/credentials"
    profile        = var.myawsprofile
    region         = var.mylocaloneregion
    dynamodb_table = "mylocalone-terraform-state-lock"
  }
  
  # "~>" means allow any minor version upgrade 
  # 5.96.1, 5.96.2, but not 5.97.0
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.96.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.3.0"
    }
  }

  required_version = ">= 1.11.4"
}

provider "aws" {
  profile = var.myawsprofile
  region  = var.mylocaloneregion

  default_tags {
    tags = {
      Environment = var.myenvironment
    }
  }
}

provider "cloudflare" {
  api_token = var.mycloudflare_api_token
}
