PROJECT OVERVIEW
This project is a Complete Microservices DevOps Platform designed to teach students how modern applications are built, containerized, deployed, and managed using DevOps tools and practices.
By completing this project, students will learn:
- Microservices architecture
- Docker containerization
- Docker Compose orchestration
- Kubernetes deployments
- CI/CD pipelines
- GitOps deployment
- Infrastructure as Code
- Monitoring and Observability
- DevSecOps security scanning
This project simulates a real production DevOps environment.

Part 1 — Clone the Repository
Students should start by cloning the project:
git clone https://github.com/YOUR_USERNAME/microservices-devops-platform.git
cd microservices-devops-platform


Part 2 — Run the Application with Docker Compose
Build and start all services:
docker compose up --build
Verify containers:
docker ps

Test application:
Frontend → http://localhost:8080
API → http://localhost:3000
Auth → http://localhost:4000
Prometheus → http://localhost:9090
Grafana → http://localhost:3001

Stop containers:
docker compose down


Part 3 — Kubernetes Deployment
Start Kubernetes cluster (Minikube or Docker Desktop).

Apply manifests:
kubectl apply -f k8s/

Verify deployment:
kubectl get pods
kubectl get svc
kubectl get deployments

Port forward frontend:
kubectl port-forward svc/frontend 8080:80

Open browser:
http://localhost:8080


Part 4 — CI/CD Pipeline
The project includes a CI/CD pipeline that:
Builds Docker images
Runs tests
Performs security scanning
Pushes images to DockerHub
Deploys to Kubernetes using GitOps

Students should push code to GitHub:
git add .
git commit -m "Project update"
git push origin main
Then check GitHub Actions to see the pipeline running.


Part 5 — GitOps Deployment (ArgoCD)
Install ArgoCD:
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Port forward ArgoCD:
kubectl port-forward svc/argocd-server -n argocd 8081:443

Get admin password:
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

Login to ArgoCD UI and connect the GitHub repository.
ArgoCD will automatically deploy the Kubernetes manifests.


Part 6 — Monitoring (Prometheus & Grafana)
Monitoring is included using Prometheus and Grafana.
Access:
Tool	URL
Prometheus	http://localhost:9090
Grafana	http://localhost:3001
Grafana login:
Username: admin
Password: admin
Add Prometheus as a data source and create dashboards.


Part 7 — Terraform Infrastructure
Terraform is used to provision cloud infrastructure such as Kubernetes clusters.
Initialize Terraform:
cd terraform
terraform init
terraform plan
terraform apply
This creates infrastructure for deploying the platform in the cloud.
Testing Checklist (VERY IMPORTANT)


Bonus Work (Advanced Students)
Bonus 1 — Centralized Logging
Add logging stack:
Loki
Promtail
Grafana Logs

Bonus 2 — Helm Charts
Package Kubernetes manifests using Helm.

Bonus 3 — Load Testing
Use:
k6
Apache JMeter

Bonus 4 — SSL / HTTPS
Add Ingress Controller and TLS certificates.
