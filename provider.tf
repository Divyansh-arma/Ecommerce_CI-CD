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
  region = var.aws_region
  access_key = "AKIARPY3JNCO2Z5VFOX5"
  secret_key = "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"

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}
