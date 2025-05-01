# Terraform Locals are named values which can be assigned and used in your code. It mainly serves the purpose of reducing duplication within the Terraform code. When you use Locals in the code, since you are reducing duplication of the same value, you also increase the readability of the code.

locals {
  bucket_name = "${var.text1}-${var.text2}"
  #####

  bucket_name = "mytest"
  env         = "dev"

  #####
  
  #Concatening lists with a local
  instance_ids = concat(aws_instance.ec1.*.id, aws_instance.ec3.*.id)

  #Map Locals
  env_tags = {
    envname = "dev"
    envteam = "devteam"
  }

  resource_tags = {
    project_name = "mytest",
    category     = "devresource"
  }

  #Using for loop in local
  prefix_elements = [for elem in ["a", "b", "c"] : format("Hello %s", elem)]

  #Using for loop and if in a local
  even_numbers = [for i in [1, 2, 3, 4, 5, 6] : i if i % 2 == 0]

  
}



resource "aws_iam_role" "myrole" {
  name = "my_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })

  tags = local.resource_tags       ################
}
