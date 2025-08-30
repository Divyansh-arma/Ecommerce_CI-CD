# Root variables for the entire infrastructure
# EC2 Module Variables
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "e-commerce"
}

variable "access_key" {
  description = "Access key for AWS account"
  type        = string
}

variable "secret_key" {
  description = "Secret key for AWS account"
  type        = string
}

# VPC Variables
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "ecommerce-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

# EC2 Variables
variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "ecommerce-server"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "ec2-key"
}

# S3 Variables
variable "bucket_name" {
  description = "Name of the S3 bucket for static files"
  type        = string
  default     = "ecommerce-bucket"
}

# Common Tags Variable
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "e-commerce"
    ManagedBy   = "terraform"
  }

}

# Elastic Beanstalk Variables

variable "elastic_beanstalk_app_name" {
  description = "Name of the Elastic Beanstalk Application"
  type        = string
  default     = "beanstalk-app"

}

variable "elastic_beanstalk_env_name" {
  description = "Name of the Elastic Beanstalk Environment"
  type        = string
  default     = "beanstalk-env"

}

variable "elastic_beanstalk_solution_stack" {
  description = "Solution stack for the Elastic Beanstalk Environment"
  type        = string
  default     = "64bit Amazon Linux 2 v3.5.7 running Docker"

}

# RDS Configuration
variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = "ecommerce-rds"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "ecommerce"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "changeme123!"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}