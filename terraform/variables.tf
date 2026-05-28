variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "devops-project"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}