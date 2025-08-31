# RDS Module Outputs

output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.db.db_instance_endpoint
<<<<<<< HEAD
  sensitive   = true
=======
>>>>>>> test
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = module.db.db_instance_port
}

output "db_instance_name" {
  description = "RDS instance database name"
  value       = module.db.db_instance_name
}

output "db_instance_username" {
  description = "RDS instance root username"
  value       = module.db.db_instance_username
  sensitive   = true
}

output "db_instance_identifier" {
  description = "RDS instance identifier"
  value       = module.db.db_instance_identifier
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = module.db.db_instance_arn
}

output "db_instance_address" {
  description = "RDS instance hostname"
  value       = module.db.db_instance_address
  sensitive   = true
}

output "db_subnet_group_id" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.rds_subnet_group.id
}

output "db_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds_sg.id
}
<<<<<<< HEAD
=======

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "db_username" {
  description = "Database username"
  value       = var.db_username
  sensitive   = true
}

output "db_password" {
  description = "Databse password"
  value = var.db_password
  sensitive = true
}
>>>>>>> test
