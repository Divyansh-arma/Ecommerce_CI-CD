module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.bucket_name
  acl    = "private"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = {
    Name        = "ecommerce-static"
    Environment = "prod"
  }

}

resource "aws_s3_object" "artifact" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "ecommerce.zip"
  source = "${path.module}/ecommerce.zip"
  etag   = filemd5("${path.module}/ecommerce-app.zip")
}

# IAM policy so Elastic Beanstalk EC2 instances can access this bucket
resource "aws_iam_policy" "s3_access" {
  name        = "eb-s3-access-prod"
  description = "Allow EB instances to access S3 static files bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "${module.s3_bucket.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "${module.s3_bucket.s3_bucket_arn}"
        ]
      }
    ]
  })
}

# Note: Policy attachment should be done in the module where the IAM role is defined
# The policy ARN is exported via outputs.tf for use in other modules