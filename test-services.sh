#!/bin/bash

echo "========================================="
echo "🔍 TESTING ALL SERVICES"
echo "========================================="

MINIKUBE_IP=$(minikube ip)

echo -e "\n📡 Direct Access (No Port-Forward):"
echo -n "  Frontend (NodePort): "
curl -s -o /dev/null -w "%{http_code}\n" http://$MINIKUBE_IP:30948

echo -n "  API (LoadBalancer): "
curl -s http://$MINIKUBE_IP:31550/health

echo -e "\n🔌 Via Port-Forward:"
echo -n "  Auth Service: "
AUTH_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/status 2>/dev/null)
if [ "$AUTH_RESPONSE" = "200" ]; then
    echo "✅ HTTP $AUTH_RESPONSE"
    curl -s http://localhost:4000/status | python3 -m json.tool 2>/dev/null | head -5
else
    echo "❌ HTTP $AUTH_RESPONSE (port-forward may not be running)"
fi

echo -n "  Prometheus: "
PROM_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9090/-/healthy 2>/dev/null)
if [ "$PROM_RESPONSE" = "200" ]; then
    echo "✅ HTTP $PROM_RESPONSE"
else
    echo "❌ HTTP $PROM_RESPONSE"
fi

echo -n "  Grafana: "
GRAF_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3001/api/health 2>/dev/null)
if [ "$GRAF_RESPONSE" = "200" ]; then
    echo "✅ HTTP $GRAF_RESPONSE"
else
    echo "❌ HTTP $GRAF_RESPONSE"
fi

echo -e "\n========================================="
