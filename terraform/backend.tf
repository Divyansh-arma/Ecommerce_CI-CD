terraform {
  backend "s3" {
    bucket         = "eccommerce-infra"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
