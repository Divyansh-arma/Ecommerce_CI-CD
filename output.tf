# Root Outputs - Main infrastructure information

# VPC Outputs
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

# EC2 Outputs
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.instance_public_ip
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2.instance_private_ip
}

# # SSH Connection Info
# output "ssh_connection" {
#   description = "SSH connection command"
#   value       = "ssh -i ~/.ssh/${var.key_name} ubuntu@${module.ec2.instance_public_ip}"
# }

# S3 Outputs
# output "bucket_name" {
#   description = "Name of the S3 bucket for static files"
#   value       = module.s3.bucket_name

# }