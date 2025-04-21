#!/bin/bash

# Stop and remove existing container if it exists
if docker ps -a | grep -q test-dev-container; then
    echo "Stopping and removing existing test-dev-container..."
    docker stop test-dev-container
    docker rm test-dev-container
fi

# Run the container
echo "Starting new test-dev-container..."
docker run -d -p 2222:22 --name test-dev-container development-level03-project-stubs:1.0.0

# Wait a moment for container to fully start
sleep 2

# Show container status
docker ps | grep test-dev-container