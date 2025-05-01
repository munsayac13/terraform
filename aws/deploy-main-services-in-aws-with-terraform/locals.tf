locals {
  vpc_id                  = aws_vpc.mylocalone.id
  mylocalone_cidr         = "10.0.0.0/16"

  mylocalone_private_a    = aws_subnet.mylocalone_subnet_private_a.cidr_block
  mylocalone_private_b    = aws_subnet.mylocalone_subnet_private_b.cidr_block
  mylocalone_public_a     = aws_subnet.mylocalone_subnet_public_a.cidr_block
  mylocalone_public_b     = aws_subnet.mylocalone_subnet_public_b.cidr_block

  myothernetwork_cidr     = "10.1.0.0/16"
  externaldevopsnode_cidr = "134.150.80.60/32"


  mylocalstaging_cidr     = "192.168.44.0/24"
  nodeonename             = "NodeOne"
  nodeonelocalname        = "NodeOne.local"
  nodeoneip               = "192.168.44.129"

  nodetwoname             = "NodeTwo"
  nodetwolocalname        = "NodeTwo.local"
  nodetwoip"              = "192.168.44.131"

  nodepostgresnoame       = "NodePostgres"
  nodepostgreslocalname   = "NodePostgres.local"
  nodepostgresip          = "192.168.44.133"
 
  externaldevopsnodename  = "OpsNode"
   
}
