resource "aws_instance" "nodeonelocal" {
  ami           = "ami-xxxxxxxxxx"
  instance_type = "r5.large"
  subnet_id     = data.aws_subnet.subnet_private_a.id
  key_name      = "mylocalone_east"

  vpc_security_group_ids = [
    aws_security_group.mylocalnodes.id
  ]


  user_data = templatefile("templates/devops-user-data.tpl", {
    hostname = var.nodeonelocalname,
    environment = var.myenvironment
  })

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 30
    volume_type           = "gp3"
    tags = {
      Name = var.nodeonelocalname
    }
  }
  
  tags = {
    Name = var.nodeonelocalname
    Environment = var.myenvironment 
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      user_data
    ]
  }

}
