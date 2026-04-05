#!/bin/bash

echo "========================================="
echo "🚀 STARTING ALL PORT-FORWARDS"
echo "========================================="

# Kill existing port-forwards
echo "Cleaning up existing port-forwards..."
pkill -f "kubectl port-forward" 2>/dev/null || true
sleep 2

# Start new port-forwards
echo "Starting port-forwards..."

# Auth Service
kubectl port-forward svc/auth-service 4000:4000 > /dev/null 2>&1 &
echo "  ✅ Auth Service: http://localhost:4000"

# Prometheus
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring > /dev/null 2>&1 &
echo "  ✅ Prometheus: http://localhost:9090"

# Grafana
kubectl port-forward svc/grafana 3001:80 -n monitoring > /dev/null 2>&1 &
echo "  ✅ Grafana: http://localhost:3001"

# Grafana Logging
kubectl port-forward -n logging svc/logging-grafana 3002:80 > /dev/null 2>&1 &
echo "  ✅ Grafana Logs: http://localhost:3002"

# ArgoCD
kubectl port-forward svc/argocd-server 8081:443 -n argocd > /dev/null 2>&1 &
echo "  ✅ ArgoCD: https://localhost:8081"

sleep 3

echo -e "\n📊 Verifying port-forwards..."
ps aux | grep "port-forward" | grep -v grep | wc -l | xargs echo "  Active port-forwards:"

echo -e "\n✅ All port-forwards started!"
echo "Run './test-services.sh' to verify connectivity"
