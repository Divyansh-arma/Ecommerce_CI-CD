# DB Subnet Group for RDS (Private Subnets)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.db_identifier}-subnet-group"
  })
}

# RDS MySQL Instance using AWS RDS Module
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.db_identifier

  # Engine configuration
  engine               = "mysql"
<<<<<<< HEAD
  engine_version       = var.engine_version
=======
  major_engine_version = var.major_engine_version
  engine_version      = var.engine_version
>>>>>>> test
  instance_class       = var.instance_class
  
  # Storage configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.allocated_storage * 2
  storage_type          = "gp2"
  storage_encrypted     = true

  # Database configuration
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = "3306"

  iam_database_authentication_enabled = true

  # Network configuration
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  # Use existing subnet group
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  
  # Publicly accessible
  publicly_accessible = false

  # Backup configuration
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  copy_tags_to_snapshot  = true

  # Maintenance configuration
  maintenance_window         = "Mon:00:00-Mon:03:00"
  auto_minor_version_upgrade = true

  # Monitoring and logging
  monitoring_interval    = 60
  monitoring_role_name   = "${var.db_identifier}-RDSMonitoringRole"
  create_monitoring_role = true
  
<<<<<<< HEAD
  enabled_cloudwatch_logs_exports = ["error", "general", "slow_query"]

  # Performance Insights
  performance_insights_enabled = true
=======
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  # Performance Insights
  performance_insights_enabled = false
>>>>>>> test
  performance_insights_retention_period = 7

  # Security configuration
  deletion_protection       = false
<<<<<<< HEAD
  skip_final_snapshot       = false
=======
  skip_final_snapshot       = true
>>>>>>> test
  final_snapshot_identifier_prefix = "${var.db_identifier}-final-snapshot"

  # DB parameter group
  family = "mysql8.0"
  
  # DB parameters
  parameters = [
    {
      name  = "innodb_buffer_pool_size"
      value = "{DBInstanceClassMemory*3/4}"
    },
    {
      name  = "max_connections"
      value = "100"
    }
  ]

  # Tags
  tags = merge(var.tags, {
    Name = "${var.db_identifier}-mysql"
    Type = "rds-instance"
  })

  # DB subnet group tags
  db_subnet_group_tags = merge(var.tags, {
    Name = "${var.db_identifier}-subnet-group"
  })

  # DB parameter group tags
  db_parameter_group_tags = merge(var.tags, {
    Name = "${var.db_identifier}-parameters"
  })

  depends_on = [
    aws_db_subnet_group.rds_subnet_group,
    aws_security_group.rds_sg
  ]
}