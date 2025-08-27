output "bucket_name" {
  description = "Name of the S3 bucket for static files"
  value       = module.s3_bucket.s3_bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket for static files"
  value       = module.s3_bucket.s3_bucket_arn
}

output "s3_access_policy_arn" {
  description = "ARN of the IAM policy for S3 access - attach this to EC2/EB instance roles"
  value       = aws_iam_policy.s3_access.arn
}