output "aws_vpc_id" {
  value = var.cloud == "aws" ? aws_vpc.main[0].id : null
}

output "aws_public_subnet_id" {
  value = var.cloud == "aws" ? aws_subnet.public[0].id : null
}

output "aws_private_subnet_id" {
  value = var.cloud == "aws" ? aws_subnet.private[0].id : null
}

output "gcp_network_id" {
  value = var.cloud == "gcp" ? google_compute_network.main[0].id : null
}

output "gcp_subnet_id" {
  value = var.cloud == "gcp" ? google_compute_subnetwork.main[0].id : null
}
