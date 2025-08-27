output "aws_iam_role" {
  description = "IAM Role for EB instances"
  value       = aws_iam_role.eb_instance_role.name
}

output "aws_iam_instance_profile" {
  description = "IAM Instance Profile for EB instances"
  value       = aws_iam_instance_profile.eb_instance_profile.name
}