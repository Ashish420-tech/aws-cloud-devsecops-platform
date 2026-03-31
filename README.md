# 🚀 AWS Cloud DevSecOps Platform

An **end-to-end DevSecOps implementation on AWS** demonstrating Infrastructure as Code, CI/CD automation, container security scanning, Kubernetes deployment, and monitoring.

This project simulates a **real-world DevOps workflow used in production environments**.

---

# 📌 Project Overview

This project builds a **secure cloud-native application platform** using AWS and DevOps best practices.

The system automatically:

• Builds container images
• Scans code and containers for vulnerabilities
• Deploys applications to Kubernetes
• Monitors application health and metrics

---

# 🧱 Architecture

Developer → GitHub → CI/CD Pipeline → Security Scans → Docker Build → ECR → EKS → Monitoring

Main workflow:

1. Developer pushes code to GitHub
2. CI/CD pipeline triggers automatically
3. Security scans run on code and containers
4. Docker image is built and pushed to Amazon ECR
5. Application is deployed to Amazon EKS
6. Monitoring stack collects metrics and logs

---

# ⚙️ Technologies Used

Cloud Platform
• AWS

Infrastructure as Code
• Terraform

Containerization
• Docker

Container Orchestration
• Kubernetes (EKS)

CI/CD
• GitHub Actions

Security (DevSecOps)
• Trivy – Container vulnerability scanning
• Checkov – Terraform security scanning
• SonarQube – Code quality & security

Monitoring & Observability
• Prometheus
• Grafana

---

# 📂 Project Structure

```
aws-cloud-devsecops-platform
│
├── app/                  # Sample application
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
│
├── terraform/            # Infrastructure as Code
│   ├── provider.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── kubernetes/           # Kubernetes deployment manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   └── namespace.yaml
│
├── cicd/                 # CI/CD pipeline configuration
│   └── github-actions.yml
│
├── security/             # DevSecOps security scans
│   ├── trivy-scan.sh
│   └── checkov-scan.sh
│
├── monitoring/           # Observability stack
│   ├── prometheus-values.yaml
│   └── grafana-values.yaml
│
├── diagrams/             # Architecture diagrams
│   └── architecture.png
│
└── README.md
```

---

# 🔐 DevSecOps Security Implementation

Security is integrated into the pipeline.

Code Security
• Static code analysis using SonarQube

Infrastructure Security
• Terraform scanning using Checkov

Container Security
• Image scanning using Trivy

Runtime Security
• Kubernetes RBAC and security best practices

---

# 🚀 Implementation Workflow

The project will be implemented in **multiple stages**.

### Stage 1 – Infrastructure Setup

Provision AWS infrastructure using Terraform:

• VPC
• Subnets
• Internet Gateway
• Amazon EKS cluster
• Amazon ECR repository

---

### Stage 2 – Application Containerization

• Build application container using Docker
• Push image to Amazon ECR

---

### Stage 3 – CI/CD Pipeline

Create automated pipeline:

• Trigger on GitHub commit
• Run security scans
• Build Docker image
• Push to container registry
• Deploy to Kubernetes

---

### Stage 4 – Kubernetes Deployment

Deploy application to Amazon EKS using:

• Deployment
• Service
• Namespace

---

### Stage 5 – DevSecOps Security

Integrate security tools:

• Trivy container scanning
• Checkov infrastructure scanning
• SonarQube code analysis

---

### Stage 6 – Monitoring & Observability

Deploy monitoring stack:

• Prometheus for metrics collection
• Grafana dashboards for visualization

---

# 📊 Key DevOps Concepts Demonstrated

• Infrastructure as Code
• Continuous Integration / Continuous Deployment
• Containerization
• Kubernetes orchestration
• DevSecOps security practices
• Observability and monitoring

---

# 🎯 Learning Objectives

This project demonstrates practical experience with:

• Cloud infrastructure design
• Automated deployment pipelines
• Secure DevOps practices
• Production-ready Kubernetes environments

---
-----
# 🚀 Latest Update: AWS 3-Tier Architecture (Manual Deployment)

## 📌 What I Built

Designed and deployed a **production-like scalable 3-tier architecture on AWS** to gain hands-on experience with real-world infrastructure and networking.

---

## 🏗️ Architecture Components

* **VPC** with public & private subnets
* **Internet Gateway & NAT Gateway**
* **EC2 Instances**

  * Frontend (Public subnet)
  * Backend (Private subnet)
* **RDS MySQL Database** (Private subnet)
* **Application Load Balancer (ALB)**
* **Auto Scaling Group (ASG)**

---

## 🔐 Security Design

* Backend instances are **not publicly accessible**
* Database is fully isolated in **private subnet**
* Only ALB is exposed to the internet
* Access controlled via **Security Groups**

---

## ⚙️ Key Features Implemented

* NAT Gateway for private subnet internet access
* Backend communication using private IP
* Spring Boot backend connected to RDS
* ALB routing traffic to backend instances
* Auto Scaling based on CPU utilization

---

## 🧪 Testing & Validation

* Verified backend API via ALB endpoint
* Inserted and retrieved data from RDS
* Simulated CPU load to test Auto Scaling
* Troubleshot real issues (NAT, routing, SSH, DB connectivity)

---

## 📸 Screenshots

> Add screenshots:

* ALB endpoint output
* Auto Scaling instances
* RDS connection
* Architecture diagram (optional)

---

## 🎯 Outcome

This phase helped me deeply understand:

* AWS networking (VPC, routing, NAT)
* Private vs public architecture design
* Load balancing and scaling
* Real-world debugging scenarios

---
===================================================================================
🚀 Latest Update: Full DevSecOps CI/CD + CD + Rollback (Last 3 Days)
📌 What I Built

Implemented a complete end-to-end DevSecOps pipeline on AWS EC2 using Jenkins, including:

✔ CI (Build + Scan)
✔ CD (Auto Deployment)
✔ Security Gates (SonarQube + Trivy)
✔ Docker + ECR integration
✔ Versioning (build-based tagging)
✔ 🔥 Rollback automation using Jenkins

🧱 Updated Architecture Flow
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
🔁 Rollback Flow (Production Control)
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
⚙️ DevSecOps Pipeline Stages (Implemented)
🔹 CI Pipeline
Code Build → Maven
Static Analysis → SonarQube
Quality Gate Enforcement
Docker Image Build
Security Scan → Trivy
🔹 CD Pipeline
AWS ECR Login
Push Versioned Image
Auto Deployment on EC2
Zero manual intervention
🔹 Versioning Strategy
demo-app:build-45
demo-app:build-46
demo-app:build-47

✔ Replaces latest (bad practice)
✔ Enables traceability
✔ Enables rollback

🔐 Security Implementation (Real DevSecOps)
Code Security

✔ SonarQube Quality Gate
✔ Security Hotspot analysis

Container Security

✔ Trivy scan (HIGH + CRITICAL vulnerabilities)

Pipeline Enforcement

✔ Block deployment on security issues
✔ Option to relax for learning

🧪 Real Issues Solved (Hands-on Debugging)

During implementation, solved real-world issues:

Docker container exiting (non-web app issue)
Port conflicts (8080 already in use)
Jenkins Java version mismatch (Java 17 fix)
Git merge conflicts in Jenkinsfile
Duplicate pipeline stages
ECR image not found (rollback issue)
Trivy pipeline failure due to vulnerabilities
SonarQube Quality Gate blocking pipeline
🎯 Key DevOps Skills Demonstrated

✔ CI/CD pipeline design
✔ Docker container lifecycle
✔ AWS ECR integration
✔ Jenkins pipeline scripting (Groovy)
✔ DevSecOps security integration
✔ Debugging production-like failures
✔ Versioned deployments
✔ 🔥 Rollback strategy implementation

📊 Final Deployment State
docker ps

✔ Running container:

demo-app:build-47

✔ Application accessible:

http://<EC2-IP>:8081
🔥 Production-Level Capabilities Achieved

✔ Automated deployment pipeline
✔ Secure code and container scanning
✔ Version-controlled releases
✔ Instant rollback capability
✔ Zero downtime deployment model

⏭️ Next Phase (In Progress)

👉 Kubernetes Deployment (Amazon EKS)

Planned:

Deploy app to EKS
Use Kubernetes Deployment & Service
Implement scaling & self-healing
Integrate with CI/CD pipeline
🎨 OPTIONAL (ADD THIS FOR ATTRACTIVENESS)
📌 Visual Flow (Simplified)
GitHub → Jenkins → Sonar → Trivy → Docker → ECR → EC2 → Live App
                              ↓
                        Rollback System
## ⏭️ Next Step

Moving this architecture to:

➡️ Terraform (Infrastructure as Code)
➡️ CI/CD automation
➡️ Kubernetes deployment
-----------------------------------------------------
# 👨‍💻 Author

Ashish Mondal

DevOps | Cloud Engineer | Kubernetes | Terraform | AWS

---

# ⭐ Future Improvements

• Implement GitOps using ArgoCD
• Add logging stack (ELK / Loki)
• Add policy enforcement using OPA Gatekeeper
• Implement advanced Kubernetes security
