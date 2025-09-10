terraform {
  backend "s3" {
    bucket = "karma-tf-states"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }
}
###