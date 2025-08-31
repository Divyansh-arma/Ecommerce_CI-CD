variable "elastic_beanstalk_app_name" {
  description = "Name of the Elastic Beanstalk Application"
  type        = string

}

variable "elastic_beanstalk_env_name" {
  description = "Name of the Elastic Beanstalk Environment"
  type        = string
}

variable "elastic_beanstalk_solution_stack" {
  description = "Solution stack for the Elastic Beanstalk Environment"
  type        = string

}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "security_group" {
  description = "Security Group for Elastic Beanstalk instances"
  type        = string
  default     = "eb-sg"

}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where Elastic Beanstalk will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Elastic Beanstalk deployment"
  type        = list(string)
}

variable "s3_access_policy_arn" {
  description = "ARN of the S3 access policy to attach to Elastic Beanstalk instance role"
  type        = string
  default     = "null"
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

variable "bucket_name" {
  description = "Name of the S3 bucket for static files"
  type        = string
  
}

variable "db_instance_endpoint" {
  description = "RDS instance endpoint"
  type        = string
  
}

variable "aws_s3_object_key" {
  description = "Key of the uploaded S3 object (application artifact)"
  type        = string
}
