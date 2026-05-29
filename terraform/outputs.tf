output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "s3_bucket_name" {
  description = "Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.bucket
}


output "ec2_private_key" {
  description = "The generated private SSH key for GitHub actions"
  value       = tls_private_key.rsa_key.private_key_pem
  sensitive   = true
}

output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}