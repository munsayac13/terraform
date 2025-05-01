variable "environment" {
  type = string
  default = "development"
}

locals {
  tags_development = {
    environment = "development"
    owner = "devteam"
  }
  tags_production = {
    environment = "production"
    owner = "prodteam"
  }
}

resource "aws_instance" "example" {
  # ... other configurations ...
  tags = lookup(local.tags_development, var.environment, local.tags_production)
}
