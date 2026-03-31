# 🚀 AWS Cloud DevSecOps Platform

> **End-to-end DevSecOps implementation on AWS** — Infrastructure as Code, CI/CD automation, container security scanning, Kubernetes deployment, and full observability.
>
> *This project simulates a real-world DevOps workflow used in production environments.*

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Architecture](#-architecture)
- [Technologies Used](#️-technologies-used)
- [Project Structure](#-project-structure)
- [DevSecOps Security Implementation](#-devsecops-security-implementation)
- [Implementation Workflow](#-implementation-workflow)
- [CI/CD Pipeline (Jenkins)](#-full-devsecops-cicd-pipeline--jenkins)
- [3-Tier Architecture (Manual Deployment)](#-aws-3-tier-architecture--manual-deployment)
- [EKS Deployment & Full Automation](#-eks-deployment--full-automation)
- [Key DevOps Concepts Demonstrated](#-key-devops-concepts-demonstrated)
- [Learning Objectives](#-learning-objectives)
- [Known Repo Issues & Cleanup Notes](#-known-repo-issues--cleanup-notes)
- [Future Improvements](#-future-improvements)
- [Author](#-author)

---

## 📌 Project Overview

This project builds a **secure cloud-native application platform** using AWS and DevOps best practices.

The system automatically:

| Capability | Description |
|---|---|
| 🏗️ Build | Builds container images from source |
| 🔐 Scan | Scans code and containers for vulnerabilities |
| 🚢 Deploy | Deploys applications to Kubernetes (EKS) |
| 📊 Monitor | Collects metrics and visualizes application health |

---

## 🧱 Architecture

```
Developer → GitHub → CI/CD Pipeline → Security Scans → Docker Build → ECR → EKS → Monitoring
```

### Main Workflow

```
1. Developer pushes code to GitHub
2. CI/CD pipeline triggers automatically
3. Security scans run on code and containers
4. Docker image is built and pushed to Amazon ECR
5. Application is deployed to Amazon EKS
6. Monitoring stack collects metrics and logs
```

---

## ⚙️ Technologies Used

| Category | Tools |
|---|---|
| ☁️ Cloud Platform | AWS |
| 📦 Infrastructure as Code | Terraform |
| 🐳 Containerization | Docker |
| ☸️ Container Orchestration | Kubernetes (EKS) |
| 🔄 CI/CD | GitHub Actions, Jenkins |
| 🔐 Security (DevSecOps) | Trivy, Checkov, SonarQube |
| 📈 Monitoring & Observability | Prometheus, Grafana |

---

## 📂 Project Structure

```
aws-cloud-devsecops-platform/
│
├── .github/
│   └── workflows/
│       └── devsecops-pipeline.yml           # GitHub Actions CI/CD workflow
│
├── app/                                     # Application source code
│   ├── Dockerfile                           # Python app container image
│   ├── app.py                               # Python application entry point
│   ├── requirements.txt                     # Python dependencies
│   └── demo-app/                            # Java Spring Boot application
│       ├── Dockerfile                       # Java app container image
│       ├── pom.xml                          # Maven build configuration
│       └── src/main/java/com/devsecops/
│           ├── DemoApplication.java         # Spring Boot main class
│           └── HelloController.java         # REST API controller
│
├── terraform/                               # Infrastructure as Code (IaC)
│   ├── provider.tf                          # AWS provider & backend config
│   ├── vpc.tf                               # VPC, subnets, IGW, NAT Gateway
│   ├── eks.tf                               # EKS cluster & node group
│   ├── variables.tf                         # Input variable declarations
│   ├── outputs.tf                           # Output values (cluster endpoint, etc.)
│   ├── ec2-jenkins/                         # Terraform config for Jenkins EC2
│   │   └── main.tf                          # Jenkins server provisioning
│   └── modules/                             # Reusable Terraform modules
│       ├── ec2/                             # EC2 instance module
│       ├── eks/                             # EKS cluster module
│       ├── iam/                             # IAM roles & policies module
│       ├── security/                        # Security groups module
│       └── vpc/                             # VPC networking module
│
├── kubernetes/                              # Kubernetes manifests
│   ├── namespace.yaml                       # Isolated namespace definition
│   ├── deployment.yaml                      # App deployment & rolling update strategy
│   └── service.yaml                         # LoadBalancer service for external access
│
├── jenkins/
│   └── Jenkinsfile                          # Declarative pipeline (Maven → Sonar → Trivy → ECR → EKS)
│
├── cicd/
│   └── github-actions.yml                   # GitHub Actions pipeline definition
│
├── security/                                # DevSecOps scanning scripts
│   ├── trivy-scan.sh                        # Container image vulnerability scan (HIGH/CRITICAL)
│   └── checkov-scan.sh                      # Terraform IaC security scan
│
├── monitoring/                              # Observability stack Helm values
│   ├── prometheus-values.yaml               # Prometheus scrape config & alert rules
│   └── grafana-values.yaml                  # Grafana dashboard & data source config
│
├── docs/
│   └── screenshots/                         # Pipeline & deployment screenshots
│
├── diagrams/
│   └── architecture.png                     # Full system architecture diagram
│
├── .gitignore
├── .dockerignore
└── README.md
```

### Directory Summary

| Directory | Purpose | Key Files |
|---|---|---|
| `.github/workflows/` | GitHub Actions automation | `devsecops-pipeline.yml` |
| `app/` | Python & Java Spring Boot apps | `app.py`, `Dockerfile`, `pom.xml` |
| `terraform/` | AWS infrastructure provisioning | `vpc.tf`, `eks.tf`, `modules/` |
| `terraform/modules/` | Reusable IaC modules (EC2, EKS, IAM, VPC) | `main.tf`, `variables.tf`, `outputs.tf` |
| `kubernetes/` | K8s workload & service definitions | `deployment.yaml`, `service.yaml` |
| `jenkins/` | Jenkins CI/CD pipeline | `Jenkinsfile` |
| `cicd/` | GitHub Actions pipeline config | `github-actions.yml` |
| `security/` | Automated security scan scripts | `trivy-scan.sh`, `checkov-scan.sh` |
| `monitoring/` | Prometheus & Grafana Helm configs | `*-values.yaml` |
| `docs/screenshots/` | Visual proof of deployments | Pipeline, EKS, SonarQube screenshots |
| `diagrams/` | Architecture diagrams | `architecture.png` |

---

## 🔐 DevSecOps Security Implementation

Security is integrated at every stage of the pipeline.

| Layer | Tool | What It Does |
|---|---|---|
| 🧪 Code Security | SonarQube | Static code analysis |
| 🏗️ Infrastructure Security | Checkov | Terraform IaC scanning |
| 🐳 Container Security | Trivy | Image vulnerability scanning |
| ☸️ Runtime Security | Kubernetes RBAC | Pod-level security best practices |

---

## 🚀 Implementation Workflow

### Stage 1 — Infrastructure Setup

Provision AWS infrastructure using Terraform:

- VPC, Subnets, Internet Gateway
- Amazon EKS cluster
- Amazon ECR repository

### Stage 2 — Application Containerization

- Build application container using Docker
- Push image to Amazon ECR

### Stage 3 — CI/CD Pipeline

Create automated pipeline:

- Trigger on GitHub commit
- Run security scans
- Build Docker image
- Push to container registry
- Deploy to Kubernetes

### Stage 4 — Kubernetes Deployment

Deploy application to Amazon EKS using:

- Deployment, Service, Namespace manifests

### Stage 5 — DevSecOps Security

Integrate security tools:

- Trivy container scanning
- Checkov infrastructure scanning
- SonarQube code analysis

### Stage 6 — Monitoring & Observability

Deploy monitoring stack:

- Prometheus for metrics collection
- Grafana dashboards for visualization

---

## 🔁 Full DevSecOps CI/CD Pipeline — Jenkins

### Updated Architecture Flow

```
Developer
   ↓
GitHub (Code Push)
   ↓
Jenkins Pipeline (CI/CD)
   ↓
Build (Maven)
   ↓
SonarQube (Code Quality & Security)
   ↓
Trivy (Container Vulnerability Scan)
   ↓
Docker Build (Versioned Image)
   ↓
Amazon ECR (Image Registry)
   ↓
EC2 Deployment (Docker Runtime)
   ↓
Live Application (Port 8081)
```

### 🔁 Rollback Flow

```
Jenkins Rollback Job
   ↓
Select IMAGE_TAG (build-XX)
   ↓
Pull from ECR
   ↓
Stop old container
   ↓
Deploy selected version
   ↓
Application restored instantly ✅
```

### Pipeline Stages

**CI Pipeline**
- Code Build → Maven
- Static Analysis → SonarQube
- Quality Gate Enforcement
- Docker Image Build
- Security Scan → Trivy

**CD Pipeline**
- AWS ECR Login
- Push Versioned Image
- Auto Deployment on EC2
- Zero manual intervention

### Versioning Strategy

```
demo-app:build-45
demo-app:build-46
demo-app:build-47
```

- ✅ Replaces `latest` (bad practice)
- ✅ Enables traceability
- ✅ Enables rollback

### 🧪 Real Issues Solved (Hands-on Debugging)

| Issue | Resolution |
|---|---|
| Docker container exiting | Fixed non-web app process handling |
| Port conflicts | Resolved 8080 already-in-use conflict |
| Jenkins Java version mismatch | Applied Java 17 fix |
| Git merge conflicts in Jenkinsfile | Resolved manually |
| Duplicate pipeline stages | Cleaned up pipeline definition |
| ECR image not found on rollback | Fixed image tag reference |
| Trivy pipeline failure | Handled vulnerability thresholds |
| SonarQube Quality Gate blocking | Configured gate rules for learning env |

### Final Deployment State

```bash
docker ps
# ✔ Running container: demo-app:build-47
# ✔ Application accessible: http://<EC2-IP>:8081
```

---

## 🏗️ AWS 3-Tier Architecture — Manual Deployment

### What Was Built

Designed and deployed a **production-like scalable 3-tier architecture on AWS** for hands-on experience with real-world infrastructure and networking.

### Architecture Components

```
┌─────────────────────────────────────────────────┐
│                   Public Subnet                  │
│  Internet Gateway → ALB → Frontend (EC2)         │
├─────────────────────────────────────────────────┤
│                  Private Subnet                  │
│           Backend (EC2) ← Auto Scaling           │
├─────────────────────────────────────────────────┤
│                  Private Subnet                  │
│              RDS MySQL Database                  │
└─────────────────────────────────────────────────┘
```

| Component | Details |
|---|---|
| VPC | Public & private subnets |
| Internet Gateway & NAT Gateway | Outbound access from private subnet |
| EC2 Instances | Frontend (public), Backend (private) |
| RDS MySQL | Isolated in private subnet |
| Application Load Balancer (ALB) | Public-facing, routes to backend |
| Auto Scaling Group (ASG) | CPU-based scaling policy |

### Security Design

- Backend instances are **not publicly accessible**
- Database is fully isolated in **private subnet**
- Only ALB is exposed to the internet
- Access controlled via **Security Groups**

### Testing & Validation

- ✅ Verified backend API via ALB endpoint
- ✅ Inserted and retrieved data from RDS
- ✅ Simulated CPU load to test Auto Scaling
- ✅ Troubleshot real issues (NAT, routing, SSH, DB connectivity)

### Key Learnings

- AWS networking (VPC, routing, NAT)
- Private vs public architecture design
- Load balancing and scaling
- Real-world debugging scenarios

---

## ☸️ EKS Deployment & Full Automation

### End-to-End DevSecOps Pipeline

```
Git Push → Jenkins → SonarQube Scan → Trivy Scan → Docker Build
       → Push to ECR → Deploy to EC2 → Deploy to EKS → Live Application
```

### Kubernetes Deployment (EKS)

- Created EKS Cluster (`ap-south-1`)
- Node Group: `m7i-flex.large`
- Configured `kubectl` access from Jenkins
- Implemented rolling deployment:

```bash
kubectl set image deployment/demo-app demo-app=<image>
```

### Application Exposure

- Service Type: `LoadBalancer`
- Access via AWS ELB URL

### Zero Downtime Deployment

```bash
# Verified with:
kubectl rollout status deployment/demo-app
```

### Screenshots

| Screenshot | Description |
|---|---|
| Jenkins Pipeline | Successful pipeline run |
| SonarQube Analysis | Code quality report |
| Trivy Scan | Container vulnerability results |
| AWS ECR Images | Versioned image registry |
| EKS Nodes | Node group status |
| EKS Pods | Running pod list |
| LoadBalancer Service | External endpoint |
| Application Output | Live app response |

> 📸 *Add screenshots to the `/diagrams` folder and update links here.*

### Key Achievements

| Achievement | Status |
|---|---|
| End-to-End DevSecOps Pipeline | ✅ |
| Security Integrated (SonarQube + Trivy) | ✅ |
| Dockerized Application | ✅ |
| AWS ECR Integration | ✅ |
| Automated Deployment to EC2 & EKS | ✅ |
| Kubernetes Rolling Updates | ✅ |
| Publicly Accessible via LoadBalancer | ✅ |

---

## 📊 Key DevOps Concepts Demonstrated

- Infrastructure as Code (Terraform)
- Continuous Integration / Continuous Deployment
- Containerization (Docker)
- Kubernetes orchestration (EKS)
- DevSecOps security practices
- Observability and monitoring (Prometheus + Grafana)
- Versioned deployments & rollback automation

---

## 🎯 Learning Objectives

This project demonstrates practical experience with:

- Cloud infrastructure design on AWS
- Automated deployment pipelines (Jenkins & GitHub Actions)
- Secure DevOps practices (SAST, container scanning, IaC scanning)
- Production-ready Kubernetes environments

---

## ⚠️ Known Repo Issues & Cleanup Notes

This section documents structural issues identified in the repository during development. These are acknowledged as learning points and will be resolved in the next cleanup phase.

### 🔴 Critical Issues

| Issue | Location | Description |
|---|---|---|
| 🔑 PEM key committed | `terraform/devsecops-key.pem` | SSH private key should **never** be committed. Add to `.gitignore` and rotate the key immediately. |
| 🔑 PEM key committed | `terraform/ec2-jenkins/jenkins-key.pem` | Same as above — exposed private key in version control. |

### 🟠 Structural Issues

| Issue | Location | Fix |
|---|---|---|
| Duplicate Kubernetes folders | `k8s/` and `kubernetes/` both exist with same files | Remove `k8s/` — keep `kubernetes/` as the single source of truth |
| Duplicate Jenkinsfiles | `Jenkinsfile` (root), `jenkins/Jenkinsfile`, and `jenknsfile` (typo) | Keep only `jenkins/Jenkinsfile`, remove the others |
| Nested Terraform directory | `terraform/terraform/` — Terraform folder inside itself | Flatten — move `modules/` and `env/` up one level |
| Screenshots dumped in root | 14 loose `.png` files in the repo root | Move all to `docs/screenshots/` |
| Empty folders committed | `cd/`, `scripts/`, `k8s-manifests/`, `terraform/ecr` | Remove empty directories or add `.gitkeep` with a note |

### 🟡 Best Practice Violations

| Issue | Location | Fix |
|---|---|---|
| Build artifacts committed | `app/demo-app/target/` | Add `target/` to `.gitignore` — compiled output should not be in git |
| Terraform provider binaries committed | Multiple `.terraform/` folders | Add `.terraform/` to `.gitignore` — run `terraform init` to restore locally |
| Terraform lock files in nested dirs | Multiple `.terraform.lock.hcl` files | Keep only one per module root; others are duplicates from nested init runs |
| Unorganised screenshot filenames | Root-level & `docs/screenshots/` | Rename files to descriptive names e.g. `jenkins-pipeline-success.png` |

### ✅ Cleanup Checklist

- [ ] Rotate and delete committed PEM keys immediately
- [ ] Add `*.pem`, `.terraform/`, and `target/` to root `.gitignore`
- [ ] Remove `k8s/` folder (duplicate of `kubernetes/`)
- [ ] Remove root `Jenkinsfile` and `jenknsfile` (typo)
- [ ] Flatten `terraform/terraform/` nested directory
- [ ] Move root-level screenshots to `docs/screenshots/`
- [ ] Delete empty folders: `cd/`, `scripts/`, `k8s-manifests/`, `terraform/ecr`
- [ ] Rename screenshots to descriptive filenames

---

## ⭐ Future Improvements

- [ ] Implement GitOps using **ArgoCD**
- [ ] Add logging stack (**ELK / Loki**)
- [ ] Add policy enforcement using **OPA Gatekeeper**
- [ ] Implement advanced **Kubernetes security**
- [ ] Migrate full infrastructure to **Terraform (IaC)**

---

## 👨‍💻 Author

**Ashish Mondal**

*DevOps | Cloud Engineer | Kubernetes | Terraform | AWS*

---

<div align="center">

⭐ If you found this project useful, consider giving it a star!

</div>
