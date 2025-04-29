resource "aws_eip" "nodeonelocal_public_ip" {
  vpc               = true
  network_interface = aws_network_interface.nodeonelocal.id
}
