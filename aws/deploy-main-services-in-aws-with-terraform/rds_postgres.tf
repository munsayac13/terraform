resource "aws_rds_cluster" "nodepostgreslocal" {
  cluster_identifier           = "nodepostgreslocal"
  engine_version               = "aurora-postgresql"
  engine_mode                  = "provisioned"
  engine_version               = "17.1"
  availability_zones           = ["us-east-1a", "us-east-1b"]
  master_username              = "devops"
  master_password              = "xxxxxxxxxxxxxx"
  storage_encrypted            = "true"
  skip_final_snapshot          = "true"
  deletion_protection          = "true"
  backup_retention_period      = 5
  preferred_backup_window      = "11:00-12:00"
  preferred_maintenance_window = "sat:10:00-sat:10:30"
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.nodepostgreslocal_cluster_param_group.name
  db_subnet_group_name         = aws_db_subnet_group.mylocalone_subnet_group.name
  vpc_security_group_ids       = [aws_security_group.default_base.id]
  enabled_cloudwatch_logs_exports = ["audit","error","general","slowquery"]

  tags = {
    Name = "NodePostgresLocal"
  }
}

resource "aws_rds_cluster_instance" "nodepostgreslocal-instance-1" {
  count                        = 1
  identifier                   = "nodepostgreslocal-instance-1"
  cluster_identifier           = aws_rds_cluster.nodepostgreslocal.id
  engine                       = aws_rds_cluster.nodepostgreslocal.engine
  engine_version               = aws_rds_cluster.nodepostgreslocal.engine_version
  instance_class               = "db.r5.large"
  auto_minor_version_upgrade   = "false"
  db_parameter_group_name      = aws_db_parameter_group.nodepostgreslocal_cluster_param_group.name

  tags = {
    Name = "NodePostgresLocal-Instance-1"
  }
}


resource "aws_rds_cluster_instance" "nodepostgreslocal-instance-2" {
  count                        = 1
  identifier                   = "nodepostgreslocal-instance-2"
  cluster_identifier           = aws_rds_cluster.nodepostgreslocal.id
  engine                       = aws_rds_cluster.nodepostgreslocal.engine
  engine_version               = aws_rds_cluster.nodepostgreslocal.engine_version
  instance_class               = "db.r5.large"
  auto_minor_version_upgrade   = "false"
  db_parameter_group_name      = aws_db_parameter_group.nodepostgreslocal_cluster_param_group.name

  tags = {
    Name = "NodePostgresLocal-Instance-2"
  }
}

resource "aws_db_subnet_group" "mylocalone_subnet_group" {
  name                    = "mylocalone_subnet_group"
  subnet_ids              = [
    data.aws_subnet.mylocalone_subnet_private_a.id,
    data.aws_subnet.mylocalone_subnet_private_b.id,
  ]

  tags = {
    Name = "MyLocalOne Subnet Group"
  }
}

resource "aws_rds_cluster_parameter_group" "nodepostgreslocal_cluster_param_group" {
  name                         = "nodepostgreslocal_cluster_param_group"
  family                       = "aurora-postgresql17"
  description                  = "NodePostgresLocal RDS Cluster Parameter Group"

  parameter {
    name = "log_rotation_age"
    value = "1d"
    apply_method = "pending-reboot"
  }

   parameter {
    name = "log_rotation_size"
    value = 0
    apply_method = "pending-reboot"
  }

  parameter {
    name = "log_min_messages"
    value = "ERROR"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "log_min_error_statement"
    value = "ERROR"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "max_connections"
    value = 1500
    apply_method = "pending-reboot"
  }

  parameter {
    name = "listen_address"
    value = "*"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "log_filename"
    value = "postgresql-%a.log"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "log_statement"
    value = "none"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "max_wal_size"
    value = "8GB"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "min_wal_size"
    value = "2GB"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_parameter_group" "nodepostgreslocal_instance_param_group" {
  name                         = "nodepostgreslocal_instance_param_group"
  family                       = "aurora-postgresql17"
  description                  = "NodePostgresLocal RDS Instance Parameter Group"

   parameter {
    name = "effective_io_concurrency"
    value = 200
    apply_method = "pending-reboot"
  }
}

resource "aws_rds_cluster_role_association" "nodepostgreslocal_load_from_s3" {
  db_cluster_identifier = aws_rds_cluster.nodepostgreslocal.id
  feature_name          = ""
  role_arn              = aws_iam_role.nodepostgreslocal_load_from_s3.arn
}

