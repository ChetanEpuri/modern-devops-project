variable "cloud"         { type = string }
variable "project_name"  { type = string }
variable "environment"   { type = string }
variable "instance_type" { type = string }
variable "aws_subnet_id" { type = string; default = "" }
variable "gcp_subnet_id" { type = string; default = "" }
variable "gcp_project_id" { type = string; default = "" }
variable "gcp_zone"      { type = string; default = "asia-south1-a" }
