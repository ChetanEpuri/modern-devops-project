output "aws_instance_ip" {
  value = var.cloud == "aws" ? aws_instance.app[0].public_ip : null
}

output "gcp_instance_ip" {
  value = var.cloud == "gcp" ? google_compute_instance.app[0].network_interface[0].access_config[0].nat_ip : null
}
