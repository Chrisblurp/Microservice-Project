# Enterprise Microservices DevOps Platform on Azure Kubernetes Service (AKS)

A complete cloud-native microservices platform demonstrating modern DevOps practices including containerization, Kubernetes orchestration, CI/CD automation, GitOps deployment, Infrastructure as Code, monitoring, centralized logging, and DevSecOps security scanning.

This project simulates a real-world production DevOps environment using enterprise-grade tools and workflows.

---

# Project Highlights

- Microservices-based application architecture
- Docker containerization
- Docker Compose local orchestration
- Kubernetes deployments
- Azure Kubernetes Service (AKS)
- CI/CD automation using GitHub Actions
- GitOps deployment with ArgoCD
- Infrastructure as Code using Terraform
- Monitoring with Prometheus and Grafana
- Centralized logging with Loki and Promtail
- NGINX Ingress Controller and HTTPS support
- DevSecOps image scanning
- Helm chart packaging
- Load testing implementation

---

# Architecture Overview

## Platform Workflow

```text
Developer Pushes Code
        ↓
GitHub Actions CI/CD Pipeline
        ↓
Build Docker Images
        ↓
Security & Vulnerability Scanning
        ↓
Push Images to DockerHub
        ↓
ArgoCD GitOps Synchronization
        ↓
Deploy to Azure Kubernetes Service (AKS)
        ↓
NGINX Ingress Routing
        ↓
Prometheus Metrics Collection
        ↓
Grafana Visualization & Monitoring
        ↓
Loki Centralized Logging
```

---

# Microservices Architecture

The platform consists of multiple independent services:

| Service | Description |
|---|---|
| Frontend Service | User interface application |
| API Service | Backend API handling requests |
| Authentication Service | User authentication & authorization |
| Monitoring Stack | Prometheus & Grafana |
| Logging Stack | Loki & Promtail |
| GitOps Controller | ArgoCD |

---

# Tech Stack

## Cloud & Infrastructure

- Microsoft Azure
- Azure Kubernetes Service (AKS)
- Terraform
- Kubernetes
- Helm

## DevOps & CI/CD

- Docker
- Docker Compose
- GitHub Actions
- ArgoCD
- GitOps Workflow

## Monitoring & Observability

- Prometheus
- Grafana
- Loki
- Promtail

## Networking & Security

- NGINX Ingress Controller
- TLS / HTTPS
- Container Security Scanning

## Development

- Node.js
- JavaScript
- YAML
- Bash

---

# Project Structure

```bash
.
├── frontend/
├── api/
├── auth-service/
├── docker-compose.yml
├── k8s/
├── helm/
├── terraform/
├── monitoring/
├── logging/
├── ingress/
├── .github/
│   └── workflows/
├── scripts/
├── screenshots/
└── README.md
```

---

# Features

- Scalable microservices architecture
- Containerized application services
- Kubernetes orchestration
- GitOps continuous deployment
- Infrastructure as Code provisioning
- Automated CI/CD pipelines
- Centralized logging
- Real-time monitoring
- Security scanning
- HTTPS ingress configuration
- Helm-based deployments
- Cloud-native infrastructure

---

# Local Development Setup

## Prerequisites

Install the following tools:

- Git
- Docker
- Docker Compose
- kubectl
- Minikube or Docker Desktop
- Helm
- Terraform
- Azure CLI

---

# Clone Repository

```bash
git clone https://github.com/Chrisblurp/Microservice-Project.git

cd microservices-devops-platform
```

---

# Run with Docker Compose

## Build & Start Services

```bash
docker compose up --build
```

## Verify Running Containers

```bash
docker ps
```

---

# Access Services Locally

| Service | URL |
|---|---|
| Frontend | http://localhost:8080 |
| API | http://localhost:3000 |
| Auth Service | http://localhost:4000 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3001 |

---

# Stop Containers

```bash
docker compose down
```

---

# Kubernetes Deployment

## Start Kubernetes Cluster

```bash
minikube start
```

OR connect to Azure Kubernetes Service (AKS).

---

# Deploy Kubernetes Manifests

```bash
kubectl apply -f k8s/
```

---

# Verify Kubernetes Resources

```bash
kubectl get pods
kubectl get svc
kubectl get deployments
```

---

# Port Forward Frontend

```bash
kubectl port-forward svc/frontend 8080:80
```

Open in browser:

```text
http://localhost:8080
```

---

# Azure Kubernetes Service (AKS)

The project infrastructure was deployed using Microsoft Azure and Azure Kubernetes Service (AKS).

---

# Connect to AKS Cluster

```bash
az aks get-credentials \
  --resource-group <RESOURCE_GROUP> \
  --name <AKS_CLUSTER_NAME>
```

---

# Verify Cluster Nodes

```bash
kubectl get nodes
```

---

# CI/CD Pipeline

The platform includes a complete GitHub Actions CI/CD pipeline that automates:

- Docker image builds
- Automated testing
- Security vulnerability scanning
- Container image publishing
- Kubernetes deployment
- GitOps synchronization

---

# GitHub Actions Workflow

Pipeline triggers on:

- Push to main branch
- Pull requests

---

# GitOps Deployment with ArgoCD

ArgoCD is used for GitOps-based Kubernetes deployment automation.

---

# Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

---

# Port Forward ArgoCD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

---

# Get ArgoCD Admin Password

```bash
kubectl get secret argocd-initial-admin-secret \
-n argocd \
-o jsonpath="{.data.password}" | base64 -d
```

---

# Monitoring & Observability

Monitoring stack includes:

- Prometheus
- Grafana
- Kubernetes metrics dashboards

---

# Monitoring URLs

| Tool | URL |
|---|---|
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3001 |

---

# Grafana Login

```text
Username: admin
Password: "get password"
```

---

# Centralized Logging

The project implements centralized logging using:

- Loki
- Promtail
- Grafana Logs

This enables centralized collection and visualization of Kubernetes application logs.

---

# Infrastructure as Code

Terraform is used to provision and manage Azure cloud infrastructure.

---

# Terraform Workflow

## Initialize Terraform

```bash
cd terraform

terraform init
```

## Plan Infrastructure

```bash
terraform plan
```

## Apply Infrastructure

```bash
terraform apply
```

---

# Helm Deployment

Kubernetes manifests were packaged and managed using Helm charts.

---

# Deploy Helm Chart

```bash
helm install microservices-platform ./helm
```

---

# DevSecOps Security Scanning

The CI/CD pipeline includes security scanning for:

- Container vulnerabilities
- Dependency vulnerabilities
- Kubernetes configuration checks

---

# Load Testing

Load testing was performed using:

- k6
- Apache JMeter

to simulate production traffic and test scalability.

---

# HTTPS & Ingress

The platform uses:

- NGINX Ingress Controller
- TLS certificates
- HTTPS routing

for secure external access to services.

---

# BashScript Testing

i also created a bash script to test the services and also automaticaly foward all ports
./
start-port-forwards.sh
test-services.sh


# Skills Demonstrated

- Azure Cloud Infrastructure
- Azure Kubernetes Service (AKS)
- Kubernetes administration
- Docker containerization
- CI/CD automation
- GitOps workflows
- Infrastructure as Code
- Helm package management
- Monitoring & observability
- Centralized logging
- DevSecOps security scanning
- Microservices architecture
- NGINX ingress configuration
- Cloud-native deployments
- Bash scripting

---


Through this project, I gained practical experience with:

- Designing microservices architectures
- Deploying scalable Kubernetes workloads
- Implementing GitOps workflows
- Automating CI/CD pipelines
- Managing Azure cloud infrastructure
- Monitoring and logging distributed systems
- Implementing DevSecOps best practices
- Managing production-style cloud-native environments

---



---
