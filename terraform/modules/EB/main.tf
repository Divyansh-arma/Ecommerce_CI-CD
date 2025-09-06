# EB Application
resource "aws_elastic_beanstalk_application" "app" {
  name        = "ecommerce-app"
  description = "E-commerce web application"
}

# EB Application Version (sample zip in S3)
resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "v1"
  application = aws_elastic_beanstalk_application.app.name
  description = "Initial version"
  bucket      = var.bucket_name
  key        = var.aws_s3_object_key
}

# EB Environment
resource "aws_elastic_beanstalk_environment" "env" {
  name                = "ecommerce-env"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.7.1 running Python 3.13"
  tier                = "WebServer"
  
  # attach the app version
  version_label       = aws_elastic_beanstalk_application_version.app_version.name

  # IAM roles
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name

  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.eb_instance_role.name
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.private_subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", var.public_subnets)
  }

  # Security group for EB instances
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.eb_sg.id
  }

  # DB connectivity (your RDS is private, so pass hostname/endpoint via env vars)
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = var.db_instance_endpoint
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = var.db_username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = var.db_password
  }

  # S3 for static files
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "STATIC_BUCKET"
    value     = var.bucket_name
  }

#   setting {
#   namespace = "aws:elasticbeanstalk:hostmanager"
#   name      = "AppSourceS3Bucket"
#   value     = 
# }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_URL"
    value     = "mysql+pymysql://${var.db_username}:${var.db_password}@${var.db_instance_address}:${var.db_instance_port}/${var.db_name}"
  }
}