resource "aws_network_interface" "nodeonelocal-public" {
  subnet_id       = data.aws_subnet.mynodeonelocal_subnet_public_a.id
  description     = "NodeOneLocal Machine Public Interface"
  security_groups = [ aws_security_group.default_security.id ]

  attachement {
    instance      = aws_instance.nodeonelocal.id
    device_index  = 2
  }
}
