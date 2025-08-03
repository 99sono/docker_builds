#!/bin/bash
# Start the development environment using docker-compose

set -e

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from .env.example..."
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "✅ Created .env from .env.example"
        echo "📝 Please review and customize .env file before proceeding"
        exit 1
    else
        echo "❌ No .env.example found. Please create .env file manually."
        exit 1
    fi
fi

# Source environment variables
export $(cat .env | xargs)

echo "=== Starting Development Environment ==="
echo "Container: ${CONTAINER_NAME}"
echo "SSH Port: ${SSH_HOST_PORT}"
echo "Dev Volume: ${DEV_VOLUME_PATH}"

# Create dev directory if it doesn't exist
mkdir -p "${DEV_VOLUME_PATH}"
mkdir -p "${SSH_KEYS_PATH}"

echo "📁 Development directory: ${DEV_VOLUME_PATH}"
echo "🔑 SSH keys directory: ${SSH_KEYS_PATH}"

# Start services
echo "🚀 Starting containers..."
docker-compose up -d

echo ""
echo "=== Development Environment Started ==="
echo ""
echo "📋 Services:"
echo "  • Main Dev Container: ${CONTAINER_NAME}"
echo "  • PostgreSQL: dev-postgres (optional)"
echo "  • Redis: dev-redis (optional)"
echo ""
echo "🔗 Access Points:"
echo "  • SSH: localhost:${SSH_HOST_PORT}"
echo "  • Node.js apps: localhost:${NODE_PORT_1}, localhost:${NODE_PORT_2}"
echo "  • Java apps: localhost:${JAVA_PORT}"
echo "  • Java Debug: localhost:${JAVA_DEBUG_PORT}"
echo "  • PostgreSQL: localhost:${POSTGRES_HOST_PORT}"
echo "  • Redis: localhost:${REDIS_HOST_PORT}"
echo ""
echo "📁 Your projects will be in: ${DEV_VOLUME_PATH}/"
echo ""
echo "Next steps:"
echo "1. Run ./03_enter_container.sh to enter the container"
echo "2. Or connect via SSH: ssh developer@localhost -p ${SSH_HOST_PORT}"
