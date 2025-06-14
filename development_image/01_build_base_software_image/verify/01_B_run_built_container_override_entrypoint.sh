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
echo "Starting new test-dev-container without triggering entrypoint script, just sleep infinity..."

# If the entrypoint script is giving problems just start the container with sleep infinity
docker run -d -p 2222:22 --name "${TEST_CONTAINER_NAME}" --entrypoint /bin/sh "${IMAGE_NAME_SUFFIX_BASE_SOFTWARE}:${IMAGE_VERSION}" -c "sleep infinity"

# Wait a moment for container to fully start
sleep 2

# Show container status
docker ps | grep test-dev-container