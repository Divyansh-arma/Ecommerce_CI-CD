resource "aws_security_group" "rds_sg" {
<<<<<<< HEAD
  name        = "${var.db_identifier}-rds-sg"
=======
  name        = "rds-sg"
>>>>>>> test
  description = "Security group for RDS MySQL database"
  vpc_id      = var.vpc_id

  # MySQL access from allowed security groups
  dynamic "ingress" {
    for_each = var.allowed_security_groups
    content {
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      security_groups = [ingress.value]
      description     = "MySQL access from security group ${ingress.value}"
    }
  }

  # MySQL access from allowed CIDR blocks
  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks
    content {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "MySQL access from CIDR ${ingress.value}"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = merge(var.tags, {
    Name = "${var.db_identifier}-rds-sg"
    Type = "rds-security-group"
  })
}
