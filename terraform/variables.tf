variable "aws_region" {
  description = "AWS region for provisioning infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "production"
}

variable "instance_type" {
  description = "EC2 instance type for host application"
  type        = string
  default     = "t3.micro"
}