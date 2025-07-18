#!/bin/bash

# Exit on error
set -e

echo "🔍 Docker Image Security Scan"
echo "============================="

# Check if Trivy is installed (&> /dev/null to suppress output)
if ! command -v trivy &> /dev/null; then
    echo "❌ Error: Trivy is not installed"
    echo "Install with: brew install trivy (macOS) or apt install trivy (Ubuntu)"
    exit 1
fi

# Function to scan single image
scan_image() {
    local image_name=$1
    local service_name=$2
    
    echo "🔍 Scanning $service_name..."
    
    # Check if image exists
    if ! docker image inspect $image_name > /dev/null 2>&1; then
        echo "⚠️  Image $image_name not found. Skipping..."
        return 1
    fi
    
    # Scan image
    echo "Running security scan on $image_name..."
    trivy image --severity HIGH,CRITICAL $image_name
    
    echo "✅ $service_name scan completed"
    echo "----------------------------------------"
    echo ""
}

# List of services to scan
SERVICES=("user-service" "order-service" "frontend")

echo "Starting security scan for microservices..."
echo ""

# Scan each service
for service in "${SERVICES[@]}"; do
    scan_image "microservices/$service:latest" "$service"
done

echo "🎉 All security scans completed!"
