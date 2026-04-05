#!/bin/bash

echo "========================================="
echo "📊 MICROSERVICES PLATFORM DASHBOARD"
echo "========================================="

MINIKUBE_IP=$(minikube ip)

echo -e "\n🌐 ACCESS URLs:"
echo "  🔹 Frontend:        http://$MINIKUBE_IP:30948"
echo "  🔹 API Service:     http://$MINIKUBE_IP:31550/health"
echo "  🔹 Auth Service:    http://localhost:4000/status (port-forward)"
echo "  🔹 Prometheus:      http://localhost:9090 (port-forward)"
echo "  🔹 Grafana:         http://localhost:3001 (port-forward)"
echo "  🔹 Grafana Logs:    http://localhost:3002 (port-forward)"
echo "  🔹 ArgoCD:          https://localhost:8081 (port-forward)"

echo -e "\n📈 Service Status:"
echo -n "  Frontend: "
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://$MINIKUBE_IP:30948)
if [ "$FRONTEND_STATUS" = "200" ]; then
    echo "✅ Running (HTTP $FRONTEND_STATUS)"
else
    echo "❌ Not accessible (HTTP $FRONTEND_STATUS)"
fi

echo -n "  API: "
API_RESPONSE=$(curl -s http://$MINIKUBE_IP:31550/health)
if [ "$API_RESPONSE" = "OK" ]; then
    echo "✅ $API_RESPONSE"
else
    echo "❌ $API_RESPONSE"
fi

echo -n "  Auth: "
AUTH_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/status 2>/dev/null)
if [ "$AUTH_RESPONSE" = "200" ]; then
    echo "✅ Running (HTTP $AUTH_RESPONSE)"
else
    echo "⚠️  Port-forward not running (HTTP $AUTH_RESPONSE)"
fi

echo -n "  Prometheus: "
PROM_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9090/-/healthy 2>/dev/null)
if [ "$PROM_RESPONSE" = "200" ]; then
    echo "✅ Healthy (HTTP $PROM_RESPONSE)"
else
    echo "⚠️  Port-forward not running"
fi

echo -e "\n📊 Kubernetes Resources:"
echo -n "  Pods Running: "
kubectl get pods --all-namespaces --field-selector=status.phase=Running 2>/dev/null | wc -l
echo -n "  Deployments: "
kubectl get deployments --all-namespaces 2>/dev/null | wc -l

echo -e "\n🔧 Quick Fix Commands:"
echo "  Start port-forwards: ./start-port-forwards.sh"
echo "  Test all services:   ./test-services.sh"
echo "  View logs:           kubectl logs -f <pod-name>"

echo -e "\n========================================="
