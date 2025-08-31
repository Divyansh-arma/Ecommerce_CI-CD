# RDS Module Variables

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "allowed_security_groups" {
  description = "List of security group IDs that can access RDS"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that can access RDS"
  type        = list(string)
  default     = []
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = "ecommerce-rds"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "major_engine_version" {
  description = "MySQL major engine version"
  type        = string
  default     = "8.0"
}



variable "tags" {
  description = "Tags to apply to RDS resources"
  type        = map(string)
  default     = {}
}
