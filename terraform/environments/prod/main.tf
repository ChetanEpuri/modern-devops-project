terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "cloud-platform-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "aws_vpc" {
  source       = "../../modules/vpc"
  cloud        = "aws"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "gcp_vpc" {
  source         = "../../modules/vpc"
  cloud          = "gcp"
  project_name   = var.project_name
  environment    = var.environment
  gcp_region     = var.gcp_region
  gcp_project_id = var.gcp_project_id
}

module "aws_compute" {
  source        = "../../modules/compute"
  cloud         = "aws"
  project_name  = var.project_name
  environment   = var.environment
  instance_type = var.aws_instance_type
  aws_subnet_id = module.aws_vpc.aws_public_subnet_id
}

module "gcp_compute" {
  source         = "../../modules/compute"
  cloud          = "gcp"
  project_name   = var.project_name
  environment    = var.environment
  instance_type  = var.gcp_instance_type
  gcp_subnet_id  = module.gcp_vpc.gcp_subnet_id
  gcp_project_id = var.gcp_project_id
}
