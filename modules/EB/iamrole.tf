# IAM Role for EB EC2s
resource "aws_iam_role" "eb_instance_role" {
  name = "eb-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "eb-instance-profile"
  role = aws_iam_role.eb_instance_role.name
}

resource "aws_iam_role_policy_attachment" "eb_web_tier" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb_worker_tier" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

# Attach S3 access policy to Elastic Beanstalk instance role
resource "aws_iam_role_policy_attachment" "eb_s3_access" {
  for_each   = var.s3_access_policy_arn != null && var.s3_access_policy_arn != "" ? toset(["attach"]) : toset([])
  #count      = length(trimspace(var.s3_access_policy_arn)) > 0 ? 1 : 0
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = var.s3_access_policy_arn
}
