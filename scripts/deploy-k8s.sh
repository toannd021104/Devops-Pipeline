#!/bin/bash

set -e  # Exit nếu có lỗi

echo "🚢 Kubernetes Deployment Script"
echo "==============================="

# Kiểm tra kubectl có cài không
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Please install kubectl first."
    exit 1
fi

# Kiểm tra kết nối cluster
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Cannot connect to Kubernetes cluster"
    echo "Start minikube: minikube start"
    exit 1
fi

echo "✅ Connected to Kubernetes cluster"
echo ""

# Deploy theo thứ tự: namespace trước, services sau
echo "📦 Creating namespace..."
kubectl apply -f k8s/shared/namespace.yaml

echo "🔧 Deploying ConfigMaps..."
kubectl apply -f k8s/user-service/configmap.yaml
kubectl apply -f k8s/order-service/configmap.yaml

echo "🚀 Deploying services..."

# Deploy User Service
echo "  Deploying user-service..."
kubectl apply -f k8s/user-service/deployment.yaml
kubectl apply -f k8s/user-service/service.yaml

# Deploy Order Service
echo "  Deploying order-service..."
kubectl apply -f k8s/order-service/deployment.yaml
kubectl apply -f k8s/order-service/service.yaml

# Deploy Frontend
echo "  Deploying frontend..."
kubectl apply -f k8s/frontend/deployment.yaml
kubectl apply -f k8s/frontend/service.yaml

# Deploy Ingress và HPA
echo "  Deploying ingress and auto-scaling..."
kubectl apply -f k8s/shared/ingress.yaml
kubectl apply -f k8s/shared/hpa.yaml

echo ""
echo "✅ Deployment completed!"
echo ""

# Hiển thị trạng thái
echo "📋 Deployment Status:"
kubectl get pods -n microservices
echo ""
kubectl get services -n microservices
echo ""
kubectl get hpa -n microservices

echo ""
echo "⏳ Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=user-service -n microservices --timeout=300s
kubectl wait --for=condition=ready pod -l app=order-service -n microservices --timeout=300s
kubectl wait --for=condition=ready pod -l app=frontend -n microservices --timeout=300s

echo "🎉 All pods are ready!"
echo ""

# Hướng dẫn access
echo "🌐 Access Information:"
echo "Add to /etc/hosts: $(minikube ip) microservices.local"
echo "Frontend: http://microservices.local"
echo "User API: http://microservices.local/api/users"
echo "Order API: http://microservices.local/api/orders"
echo ""
echo "📊 Monitor scaling:"
echo "kubectl get hpa -n microservices -w"