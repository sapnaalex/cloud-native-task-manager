terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Security Group for Task Manager API
resource "aws_security_group" "api_sg" {
  name        = "task-manager-api-sg-${var.environment}"
  description = "Allow inbound HTTP, HTTPS, and SSH traffic"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "task-manager-sg"
    Environment = var.environment
  }
}

# 2. S3 Bucket for Task Storage/Attachments
resource "aws_s3_bucket" "task_attachments" {
  bucket        = "cloud-native-task-attachments-${var.environment}-db"
  force_destroy = true

  tags = {
    Name        = "Task Attachments Storage"
    Environment = var.environment
  }
}