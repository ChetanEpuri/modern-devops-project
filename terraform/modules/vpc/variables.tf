variable "cloud" {
  description = "Cloud provider: aws or gcp"
  type        = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "gcp_region" {
  type    = string
  default = "asia-south1"
}

variable "gcp_project_id" {
  type    = string
  default = ""
}
