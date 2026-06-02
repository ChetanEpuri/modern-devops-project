# Architecture

## System overview

The platform consists of five layers:

**Layer 1 — Security CI pipeline**
GitHub Actions with TruffleHog, Safety, and Trivy scanning on every push.

**Layer 2 — Infrastructure as Code**
Terraform provisioning VPC, EKS, EC2, RDS, and S3 on AWS.

**Layer 3 — Automated deployment**
Docker images pushed to DockerHub, deployed to EC2 via SSH.

**Layer 4 — Kubernetes + GitOps**
EKS cluster with Helm charts, ArgoCD self-healing, HPA auto-scaling.

**Layer 5 — Observability**
Prometheus metrics, Grafana dashboards, AlertManager Slack alerts.