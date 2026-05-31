resource "aws_vpc" "main" {
  count            = var.cloud == "aws" ? 1 : 0
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Cloud       = "aws"
  }
}

resource "aws_subnet" "public" {
  count                   = var.cloud == "aws" ? 1 : 0
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-public"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count             = var.cloud == "aws" ? 1 : 0
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.project_name}-${var.environment}-private"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "main" {
  count  = var.cloud == "aws" ? 1 : 0
  vpc_id = aws_vpc.main[0].id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "google_compute_network" "main" {
  count                   = var.cloud == "gcp" ? 1 : 0
  name                    = "${var.project_name}-${var.environment}-vpc"
  auto_create_subnetworks = false
  project                 = var.gcp_project_id
}

resource "google_compute_subnetwork" "main" {
  count         = var.cloud == "gcp" ? 1 : 0
  name          = "${var.project_name}-${var.environment}-subnet"
  ip_cidr_range = "10.1.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.main[0].id
  project       = var.gcp_project_id
}
