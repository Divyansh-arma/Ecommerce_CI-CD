# EC2 Module - creates EC2 instance with latest Ubuntu AMI

data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# EC2 Instance
resource "aws_instance" "ecommerce" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.subnet_id

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}