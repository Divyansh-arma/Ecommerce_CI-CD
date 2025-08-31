# VPC Module Variables

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

<<<<<<< HEAD
variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}
=======
# variable "vpc_id" {
#   description = "VPC ID where the security group will be created"
#   type        = string
# }
>>>>>>> test

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
<<<<<<< HEAD
=======

>>>>>>> test
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
<<<<<<< HEAD
=======

>>>>>>> test
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
