locals {
  vpc_id                  = "vpc-XXXXXXXX"

  mylocalone_cidr         = "192.168.44.0/24"
  myothernetwork_cidr     = "10.0.0.0/16"
  externaldevopsnode_cidr = "134.150.80.60/32"


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
