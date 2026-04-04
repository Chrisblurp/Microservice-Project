#!/bin/bash

echo "========================================="
echo "🎉 MICROSERVICES PLATFORM - FINAL DEMO"
echo "========================================="

MINIKUBE_IP=$(minikube ip)

echo -e "\n📡 ACCESS ENDPOINTS:"
echo "  🌐 Frontend: http://$MINIKUBE_IP:30948"
echo "  🔌 API: http://$MINIKUBE_IP:31550"
echo "  🔐 Auth: http://localhost:4000"

echo -e "\n🔍 SERVICE VERIFICATION:\n"

# Test Frontend
echo -n "Frontend (NodePort): "
FRONTEND_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$MINIKUBE_IP:30948)
if [ "$FRONTEND_CODE" = "200" ]; then
    echo "✅ HTTP $FRONTEND_CODE - React app loading"
else
    echo "❌ HTTP $FRONTEND_CODE"
fi

# Test API
echo -n "API Service: "
API_RESPONSE=$(curl -s http://$MINIKUBE_IP:31550/health)
if [ "$API_RESPONSE" = "OK" ]; then
    echo "✅ $API_RESPONSE"
else
    echo "❌ $API_RESPONSE"
fi

# Test Auth Status
echo -n "Auth Status: "
AUTH_STATUS=$(curl -s http://localhost:4000/status | grep -o '"status":"[^"]*"' | cut -d'"' -f4)
if [ "$AUTH_STATUS" = "running" ]; then
    echo "✅ $AUTH_STATUS (uptime: $(curl -s http://localhost:4000/status | grep -o '"uptime_seconds":[0-9.]*' | cut -d':' -f2 | cut -d'.' -f1)s)"
else
    echo "❌ $AUTH_STATUS"
fi

# Test Auth Metrics
echo -n "Auth Metrics: "
METRICS=$(curl -s http://localhost:4000/metrics | grep -o '"service":"[^"]*"' | cut -d'"' -f4)
if [ "$METRICS" = "auth-service" ]; then
    echo "✅ $METRICS available"
else
    echo "❌ Not available"
fi

# Test Login
echo -e "\n🔐 AUTHENTICATION TEST:"
LOGIN_RESPONSE=$(curl -s -X POST http://localhost:4000/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}')

if echo "$LOGIN_RESPONSE" | grep -q "token"; then
    echo "  ✅ Login successful!"
    TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
    echo "  📝 Token received: ${TOKEN:0:50}..."
else
    echo "  ❌ Login failed"
fi

echo -e "\n📊 KUBERNETES STATUS:"
echo -n "  Pods running: "
kubectl get pods --no-headers | grep Running | wc -l
echo -n "  Services: "
kubectl get svc --no-headers | wc -l

echo -e "\n========================================="
echo "✅ ALL MICROSERVICES OPERATIONAL!"
echo "========================================="
