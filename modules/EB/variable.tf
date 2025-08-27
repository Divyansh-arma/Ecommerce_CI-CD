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

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
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
  default     = ""
}
