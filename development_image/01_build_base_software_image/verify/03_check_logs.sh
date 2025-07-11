#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  

# Check if container exists
if ! docker inspect ${TEST_CONTAINER_NAME} >/dev/null 2>&1; then
    echo "ERROR: Container ${TEST_CONTAINER_NAME} does not exist!"
    exit 1
fi

# Check the container logs
docker logs ${TEST_CONTAINER_NAME}
