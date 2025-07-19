#!/bin/bash
#  ex: ./scripts/push-images.sh <latest> <docker.io> <toanndcloud>


set -e

echo "🚀 Docker Image Push Script"
echo "==========================="

# Get parameters
VERSION=${1:-"latest"} # Default to "latest" if not provided
REGISTRY=${2:-"docker.io"} # Default to "docker.io" if not provided
USERNAME=${3}

# Show example 
if [ -z "$USERNAME" ]; then
    echo "❌ Error: Username is required"
    echo ""
    echo "Usage: $0 <version> [registry] <username>"
    echo ""
    echo "Examples:"
    echo "  $0 v1.0.0 docker.io myusername"
    echo "  $0 latest docker.io myusername"
    echo "  $0 v1.2.0 ghcr.io myusername"
    echo ""
    exit 1
fi

echo "Push configuration:"
echo "Version: $VERSION"
echo "Registry: $REGISTRY"
echo "Username: $USERNAME"
echo ""

# Check Docker login
check_docker_login() {
    echo "🔐 Checking Docker authentication..."
    
    if ! docker info > /dev/null 2>&1; then
        echo "❌ Docker daemon is not running"
        exit 1
    fi
    
    echo "✅ Docker is running"
    echo "💡 Make sure you're logged in: docker login $REGISTRY"
    echo ""
}

# Function to push service
push_service() {
    local service_name=$1 #Bien cuc bo = Tham so dau tien truyen vao ham
    local local_image="microservices/$service_name"
    local remote_image="$REGISTRY/$USERNAME/$service_name"
    
    echo "📦 Processing $service_name..."
    
    # Check if local image exists
    if ! docker image inspect "$local_image:$VERSION" > /dev/null 2>&1; then
        echo "❌ Local image $local_image:$VERSION not found"
        echo "   Run: ./scripts/build-images.sh $VERSION"
        return 1
    fi
    
    echo "🏷️  Tagging images..."
    
    # Tag for image local
    docker tag "$local_image:$VERSION" "$remote_image:$VERSION"
    docker tag "$local_image:latest" "$remote_image:latest"
    
    # Try to get commit hash tag and tag for image
    if docker image inspect "$local_image" --format '{{.RepoTags}}' | grep -q "microservices/$service_name:" | grep -v ":latest\|:$VERSION"; then
        local commit_tags=$(docker image inspect "$local_image" --format '{{.RepoTags}}' | grep -o "microservices/$service_name:[a-f0-9]\{7\}" | head -1)
        if [ ! -z "$commit_tags" ]; then
            local commit_hash=$(echo $commit_tags | cut -d':' -f2)
            docker tag "$local_image:$commit_hash" "$remote_image:$commit_hash"
        fi
    fi
    
    echo "🚀 Pushing to registry..."
    
    # Push version tag
    echo "   Pushing $remote_image:$VERSION..."
    if docker push "$remote_image:$VERSION"; then
        echo "   ✅ Version tag pushed"
    else
        echo "   ❌ Failed to push version tag"
        return 1
    fi
    
    # Push latest tag
    echo "   Pushing $remote_image:latest..."
    if docker push "$remote_image:latest"; then
        echo "   ✅ Latest tag pushed"
    else
        echo "   ❌ Failed to push latest tag"
        return 1
    fi
    
    # Push commit hash if exists
    if [ ! -z "$commit_hash" ]; then
        echo "   Pushing $remote_image:$commit_hash..."
        if docker push "$remote_image:$commit_hash"; then
            echo "   ✅ Commit tag pushed"
        else
            echo "   ⚠️  Failed to push commit tag (non-critical)"
        fi
    fi
    
    echo "✅ $service_name pushed successfully!"
    echo ""
}

# Main execution
check_docker_login

# Services to push
SERVICES=("user-service" "order-service" "frontend")
PUSHED_SERVICES=0
FAILED_SERVICES=0

echo "🚀 Starting push process..."
echo ""

# Push each service
for service in "${SERVICES[@]}"; do
    if push_service "$service"; then
        PUSHED_SERVICES=$((PUSHED_SERVICES + 1))
    else
        FAILED_SERVICES=$((FAILED_SERVICES + 1))
        echo "❌ Failed to push $service"
        echo ""
    fi
done

# Summary
echo "📋 PUSH SUMMARY"
echo "==============="
echo "Services pushed successfully: $PUSHED_SERVICES"
echo "Services failed: $FAILED_SERVICES"
echo ""

if [ $FAILED_SERVICES -gt 0 ]; then
    echo "❌ Some services failed to push"
    echo "Check Docker login and network connection"
    exit 1
else
    echo "🎉 All services pushed successfully!"
    echo ""
    echo "Images available at:"
    for service in "${SERVICES[@]}"; do
        echo "  - $REGISTRY/$USERNAME/$service:$VERSION"
    done
fi
