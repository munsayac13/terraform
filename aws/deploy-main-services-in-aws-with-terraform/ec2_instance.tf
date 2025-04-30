resource "aws_instance" "nodeonelocal" {
  ami           = "ami-xxxxxxxxxx"
  instance_type = "r5.large"
  subnet_id     = data.aws_subnet.mylocalone_subnet_private_a.id
  key_name      = "mylocalone_east"

  vpc_security_group_ids = [
    aws_security_group.default_base.id
  ]


  user_data = templatefile("templates/devops-user-data.tpl", {
    hostname = local.nodeonelocalname,
    environment = var.myenvironment
  })

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 30
    volume_type           = "gp3"
    tags = {
      Name = local.nodeonelocalname
    }
  }
  
  tags = {
    Name = local.nodeonelocalname
    Environment = var.myenvironment 
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      user_data
    ]
  }

}

resource "aws_instance" "nodeactivemqlocal" {
  ami           = "ami-xxxxxxxxxx"
  instance_type = "t4.large"
  subnet_id     = data.aws_subnet.mylocalone_subnet_private_a.id
  key_name      = "mylocalone_east"

  vpc_security_group_ids = [
    aws_security_group.default_base.id,
    aws_security_group.activemq.id
  ]

  user_data = templatefile("templates/devops-user-data.tpl", {
    hostname = local.nodeactivemqlocalname,
    environment = var.myenvironment
  })

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp3"
    tags = {
      Name = local.nodeactivemqlocalname
    }
  }
  
  tags = {
    Name = local.nodeactivemqlocalname
    Environment = var.myenvironment 
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      user_data
    ]
  }
}
