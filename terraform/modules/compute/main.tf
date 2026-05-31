resource "aws_instance" "app" {
  count         = var.cloud == "aws" ? 1 : 0
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type
  subnet_id     = var.aws_subnet_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-server"
    Environment = var.environment
  }
}

resource "google_compute_instance" "app" {
  count        = var.cloud == "gcp" ? 1 : 0
  name         = "${var.project_name}-${var.environment}-server"
  machine_type = var.instance_type
  zone         = var.gcp_zone
  project      = var.gcp_project_id

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.gcp_subnet_id
    access_config {}
  }

  tags = [var.environment]
}
