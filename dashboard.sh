#!/bin/bash

echo "========================================="
echo "📊 MICROSERVICES PLATFORM DASHBOARD"
echo "========================================="

MINIKUBE_IP=$(minikube ip)

echo -e "\n🌐 ACCESS URLs:"
echo "  🔹 Frontend:        http://$MINIKUBE_IP:30948"
echo "  🔹 API Service:     http://$MINIKUBE_IP:31550/health"
echo "  🔹 Auth Service:    http://localhost:4000/status"
echo "  🔹 Prometheus:      http://localhost:9090"
echo "  🔹 Grafana (Logs):  http://localhost:3002"
echo "  🔹 ArgoCD:          https://localhost:8081"

echo -e "\n📈 Service Status:"
echo -n "  Frontend: "
curl -s -o /dev/null -w "%{http_code}\n" http://$MINIKUBE_IP:30948

echo -n "  API: "
curl -s http://$MINIKUBE_IP:31550/health

echo -n "  Auth: "
curl -s http://localhost:4000/status 2>/dev/null | grep -q "running" && echo "✅ Running" || echo "⚠️ Start port-forward"

echo -e "\n📊 Resource Usage:"
kubectl top pods --all-namespaces 2>/dev/null | head -10

echo -e "\n========================================="
echo "To start all port-forwards:"
echo "  kubectl port-forward svc/auth-service 4000:4000 &"
echo "  kubectl port-forward svc/prometheus-server 9090:80 &"
echo "  kubectl port-forward -n logging svc/logging-grafana 3002:80 &"
echo "========================================="
