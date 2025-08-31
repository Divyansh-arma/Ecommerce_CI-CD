# Main Terraform configuration to invoke all modules

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  # vpc_id          = module.vpc.vpc_id
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  tags = var.common_tags
}

# EC2 Module
module "ec2" {
  source          = "./modules/ec2"
  access_key      = var.access_key
  secret_key      = var.secret_key
  instance_name   = var.instance_name
  instance_type   = var.instance_type
  key_name        = var.key_name
  public_key_path = "/Users/divyansh/Documents/DevOps/Pem-Keys/Ecommerce-keys/ec2-key.pub"
  subnet_id       = module.vpc.public_subnets[0]
  vpc_id          = module.vpc.vpc_id

  tags = var.common_tags

  depends_on = [module.vpc]
}

# S3 Module
module "s3" {
  source      = "./modules/S3"
  bucket_name = var.bucket_name
}

# EB Module
module "eb" {
  source                           = "./modules/EB"
  bucket_name                      = var.bucket_name
  db_name                          = var.db_name
  db_username                      = var.db_username
  db_password                      = var.db_password
  db_instance_endpoint             = module.rds.db_instance_endpoint
  aws_region                       = var.aws_region
  elastic_beanstalk_app_name       = var.elastic_beanstalk_app_name
  elastic_beanstalk_env_name       = var.elastic_beanstalk_env_name
  elastic_beanstalk_solution_stack = var.elastic_beanstalk_solution_stack
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.public_subnets
  public_subnets                   = module.vpc.public_subnets
  private_subnets                  = module.vpc.private_subnets
  s3_access_policy_arn             = module.s3.s3_access_policy_arn
  aws_s3_object_key = module.s3.aws_s3_object_key
  tags                             = var.common_tags
  depends_on                       = [module.vpc, module.s3]
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  # Network Configuration
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  # Security Configuration - Allow access from EC2 and EB instances
  allowed_security_groups = [
    module.ec2.security_group_id,
    module.eb.security_group_id
  ]

  # Database Configuration
  db_identifier     = var.db_identifier
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  # Common tags
  tags = var.common_tags

  depends_on = [module.vpc, module.ec2, module.s3]
}
