#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting Deployment Process..."

# 1. Check if Docker is running
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed or not in PATH."
    exit 1
fi

# 2. Build and start containers in detached mode
echo "📦 Building and starting Docker containers..."
docker-compose down --remove-orphans
docker-compose up --build -d

# 3. Wait for services to initialize
echo "⏳ Waiting 5 seconds for API service to initialize..."
sleep 5

# 4. Verify health endpoint
echo "🔍 Checking application health status..."
HEALTH_CHECK=$(curl -s http://localhost/health || true)

if [[ "$HEALTH_CHECK" == *"UP"* ]]; then
    echo "✅ Deployment Successful! Task Manager API is UP and running behind Nginx Proxy."
else
    echo "⚠️ Warning: Health check did not return expected response. Output: $HEALTH_CHECK"
fi