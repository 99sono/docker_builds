#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  

# Stop and remove existing container if it exists
if docker ps -a | grep -q ${TEST_CONTAINER_NAME}; then
    echo "Stopping and removing existing ${TEST_CONTAINER_NAME}..."
    docker stop ${TEST_CONTAINER_NAME}
    docker rm ${TEST_CONTAINER_NAME}
fi

# Run the container
echo "Starting new test-dev-container..."
docker run -d -p 2222:22 --name ${TEST_CONTAINER_NAME} "${IMAGE_NAME_SUFFIX_BASE_SOFTWARE}:${IMAGE_VERSION}"

# Wait a moment for container to fully start
sleep 2

# Show container status
docker ps | grep test-dev-container