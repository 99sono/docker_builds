#!/bin/bash

# Push the tagged Docker image to Docker Hub
#
# This script pushes the previously tagged image to the public Docker Hub repository

set -e

# Source environment variables
source ../00_common_env.sh

echo "📤 Pushing tagged image to Docker Hub"
echo "======================================"
echo "Pushing image: ${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"
echo ""

# Verify Docker is logged in by checking if authentication exists
if ! docker system info | grep -q "Username:"; then
    echo "❌ ERROR: Docker is not logged in!"
    echo "Please run 'docker login' first to authenticate with Docker Hub."
    echo ""
    echo "Example:"
    echo "  docker login"
    echo "  # Enter your Docker Hub username and password/personal access token"
    exit 1
fi

# Push the tagged image to Docker Hub
docker push "${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"

echo ""
echo "✅ Image pushed successfully!"
echo "Available at: https://hub.docker.com/repository/docker/${DOCKER_HUB_REPO_NAME}"
echo ""
echo "Users can pull the image with:"
echo "  docker pull ${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"
