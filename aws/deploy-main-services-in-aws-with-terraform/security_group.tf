resource "aws_security_group" "default_security" {
  name          = "default_security"
  description   = "Allow basic access to servers"
  vpc_id        = local.vpc_id

  ingress {
    description = "SSH from OtherNetwork"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr, local.externaldevopsnode_cidr  ]
  }

  ingress {
    description = "SNMP from OtherNetwork"
    from_port   = 161
    to_port     = 161
    protocol    = "udp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "WINDMILL from OtherNetwork"
    from_port   = 6969
    to_port     = 6969
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "Jenkins from OtherNetwork"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "HTTP from OtherNetwork"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "HTTPS from OtherNetwork"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "Postgres from OtherNetwork"
    from_port   = 5432
    to_port     = 5342
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }

  ingress {
    description = "Redis from OtherNetwork"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [ local.myothernetwork_cidr ]
  }


  ingress {
    description = "ICMP"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [ "0.0.0.0/0" ] # Allow traffic from any IPv4 Address
  }

  egress {
    description = "Outbound traffic to Anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "default_security"
  }
}

resource "aws_security_group" "activemq" {
  name                    = "activemq"
  description             = "Access to AMQ Servers"
  vpc_id                  = local.vpc_id

  ingress {
    description           = "ActiveMQ JMX"
    from_port             = 1099
    to_port               = 1099
    protocol              = "tcp"
    cidr_blocks           = [local.mylocalone_cidr]
  }

  ingress {
    description           = "ActiveMQ RMI"
    from_port             = 1100
    to_port               = 1100
    protocol              = "tcp"
    cidr_blocks           = [local.mylocalone_cidr]
  }

  ingress {
    description           = "ActiveMQ Clients"
    from_port             = 61616
    to_port               = 61616
    protocol              = "tcp"
    cidr_blocks           = [local.mylocalone_cidr]
  }

  ingress {
    description           = "ActiveMQ Web UI"
    from_port             = 8161
    to_port               = 8161
    protocol              = "tcp"
    cidr_blocks           = [local.mylocalone_cidr]
  }

  tags = {
    Name = "ActiveMQ"
  }

}
