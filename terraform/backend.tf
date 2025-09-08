terraform {
  backend "s3" {
    bucket = "karma-tf-state"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}
#