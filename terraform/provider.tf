# Terraform configuration
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}
# test CI-CD
