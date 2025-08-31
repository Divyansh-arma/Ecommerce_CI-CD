# VPC Module - creates VPC with public and private subnets

# Data source to fetch AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Creation
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

<<<<<<< HEAD
  azs             = [data.aws_availability_zones.available.names[0]]
=======
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
>>>>>>> test
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.tags

  public_subnet_tags = {
    Type = "public"
  }

  private_subnet_tags = {
    Type = "private"
  }
}
