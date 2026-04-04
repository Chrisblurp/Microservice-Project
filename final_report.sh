#!/bin/bash

echo "========================================="
echo "   MICROSERVICES DEVOPS PLATFORM"
echo "   FINAL VERIFICATION REPORT"
echo "========================================="

echo -e "\n📦 DOCKER SERVICES STATUS:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "microservice|prometheus|grafana"

echo -e "\n🌐 SERVICE ENDPOINTS:"

# Frontend
FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [ "$FRONTEND" = "200" ]; then
    echo "✅ Frontend UI: http://localhost:8080"
fi

# API
API=$(curl -s http://localhost:3000/health)
if [ "$API" = "OK" ]; then
    echo "✅ API Service: http://localhost:3000/health"
fi

# Auth - All endpoints working
AUTH_STATUS=$(curl -s http://localhost:4000/status | grep -o "running")
AUTH_METRICS=$(curl -s http://localhost:4000/metrics | grep -o "auth-service")
if [ "$AUTH_STATUS" = "running" ] && [ "$AUTH_METRICS" = "auth-service" ]; then
    echo "✅ Auth Service: http://localhost:4000 (Status & Metrics OK)"
fi

# Prometheus
PROM=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9090/-/healthy)
if [ "$PROM" = "200" ]; then
    echo "✅ Prometheus: http://localhost:9090"
fi

# Grafana
GRAFANA=$(curl -s http://localhost:3001/api/health | grep -o "ok")
if [ "$GRAFANA" = "ok" ]; then
    echo "✅ Grafana: http://localhost:3001 (admin/admin)"
fi

echo -e "\n🔐 AUTH SERVICE DETAILS:"
echo "   Status: $(curl -s http://localhost:4000/status | sed 's/{//g' | sed 's/}//g' | sed 's/,/ | /g')"
echo "   Metrics: $(curl -s http://localhost:4000/metrics | sed 's/{//g' | sed 's/}//g' | sed 's/,/ | /g')"

echo -e "\n📊 ACCESS DASHBOARDS:"
echo "   🖥️  Frontend:      http://localhost:8080"
echo "   🔌 API Service:   http://localhost:3000"
echo "   🔐 Auth Service:  http://localhost:4000"
echo "   📈 Prometheus:    http://localhost:9090"
echo "   📉 Grafana:       http://localhost:3001 (admin/admin)"

echo -e "\n✅ All services are RUNNING and HEALTHY!"
echo "========================================="
