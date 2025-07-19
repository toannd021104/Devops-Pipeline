#!/bin/bash
# set -e: Exit immediately if a command exits with a non-zero status.
set -e

echo "🔍 Docker Image Security Scan"

echo "============================="

# Check Trivy installation
# &>/dev/null: Redirects both stdout and stderr to /dev/null, effectively silencing the command.
if ! command -v trivy &> /dev/null; then

    echo "❌ Error: Trivy is not installed"

    exit 1

fi

# Create results directory

mkdir -p scan-results

# Counters for summary

TOTAL_SCANNED=0

TOTAL_VULNERABILITIES=0

CRITICAL_FOUND=0

# Function to scan image with JSON output

scan_image() {

    local image_name=$1

    local service_name=$2

    

    echo "🔍 Scanning $service_name..."

    

    if ! docker image inspect $image_name > /dev/null 2>&1; then

        echo "⚠️  Image $image_name not found. Skipping..."

        return 1

    fi

    

    # Scan with JSON output

    local json_file="scan-results/${service_name}-scan.json"

    

    echo "Running security scan on $image_name..."

    

    # Scan and save JSON

    trivy image --format json --output $json_file $image_name

    

    # Show human-readable results

    trivy image --severity HIGH,CRITICAL $image_name

    

    # Count vulnerabilities from JSON

    local vuln_count=$(cat $json_file | grep -o '"Severity":"HIGH"\|"Severity":"CRITICAL"' | wc -l || echo "0")

    local critical_count=$(cat $json_file | grep -o '"Severity":"CRITICAL"' | wc -l || echo "0")

    

    TOTAL_SCANNED=$((TOTAL_SCANNED + 1))

    TOTAL_VULNERABILITIES=$((TOTAL_VULNERABILITIES + vuln_count))

    CRITICAL_FOUND=$((CRITICAL_FOUND + critical_count))

    

    echo "📊 $service_name: $vuln_count HIGH/CRITICAL vulnerabilities ($critical_count CRITICAL)"

    echo "✅ Results saved to $json_file"

    echo "----------------------------------------"

    echo ""

}

# Services to scan

SERVICES=("user-service" "order-service" "frontend")

echo "Starting security scan for microservices..."

echo ""

# Scan all services

for service in "${SERVICES[@]}"; do

    scan_image "microservices/$service:latest" "$service"

done

# Show summary

echo "📋 SCAN SUMMARY"

echo "==============="

echo "Images scanned: $TOTAL_SCANNED"

echo "Total HIGH/CRITICAL vulnerabilities: $TOTAL_VULNERABILITIES"

echo "Critical vulnerabilities: $CRITICAL_FOUND"

echo ""

# Fail build if critical vulnerabilities found

if [ $CRITICAL_FOUND -gt 0 ]; then

    echo "❌ CRITICAL vulnerabilities found! Build should not proceed to production."

    echo "Review scan results in scan-results/ directory"

    exit 1

else

    echo "✅ No CRITICAL vulnerabilities found. Safe to proceed."

fi

echo ""

echo "📁 Detailed results available in scan-results/ directory"