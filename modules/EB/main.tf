#  Elastic Beanstalk Application
module "elastic_beanstalk_app" {
  source  = "cloudposse/elastic-beanstalk-application/aws"
  version = "0.12.1"
  name        = "beanstalk-app"
  description = "Elastic Beanstalk Application for sample e-commerce"
}

# Elastic Beanstalk Environment
module "elastic_beanstalk_env" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  region  = var.aws_region
  version = "0.41.0"
  application_subnets = var.public_subnets
  elastic_beanstalk_application_name  = module.elastic_beanstalk_app.elastic_beanstalk_application_name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.7 running Docker"

  # Networking
  vpc_id     = var.vpc_id

  # EC2 settings
  instance_type          = "t3.micro"
  associate_public_ip_address = true

  # Load balancer type
  loadbalancer_type = "application"

  tags = {
    Environment = "prod"
    Project     = "ecommerce"
  }
}