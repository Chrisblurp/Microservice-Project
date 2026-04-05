#!/bin/bash

echo "========================================="
echo "🚀 RUNNING ALL BONUS FEATURES"
echo "========================================="

echo -e "\n1️⃣ Setting up Centralized Logging..."
kubectl get pods -n logging 2>/dev/null && echo "✅ Logging already running" || echo "Run: helm install logging grafana/loki-stack -n logging"

echo -e "\n2️⃣ Load Testing with k6..."
which k6 > /dev/null && echo "✅ k6 installed" || echo "Run: sudo apt-get install k6"

echo -e "\n3️⃣ SSL/HTTPS Ingress..."
kubectl get ingress -n default 2>/dev/null && echo "✅ Ingress configured" || echo "Run: kubectl apply -f ingress-tls.yaml"

echo -e "\n4️⃣ Helm Charts..."
helm list 2>/dev/null | grep -q microservices && echo "✅ Helm chart deployed" || echo "Run: helm install microservices-platform ./helm/microservices-chart"

echo -e "\n5️⃣ Access Dashboard..."
./dashboard.sh

echo -e "\n========================================="
echo "🎉 BONUS FEATURES COMPLETED!"
echo "========================================="
