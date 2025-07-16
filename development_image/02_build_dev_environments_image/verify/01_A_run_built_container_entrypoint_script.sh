#!/bin/bash
source ../../00_common_env.sh


#IMAGE_NAME="development-level02-dev-environments:1.0.0"
IMAGE_NAME="{IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:{IMAGE_VERSION}"

# Stop and remove existing container if it exists
docker stop ${TEST_CONTAINER_NAME} >/dev/null 2>&1
docker rm ${TEST_CONTAINER_NAME} >/dev/null 2>&1

# Run container with Level 02 image on different port
docker run -d -p 2223:22 --name ${TEST_CONTAINER_NAME} ${IMAGE_NAME}

# Wait for container to initialize
sleep 2
docker ps | grep ${TEST_CONTAINER_NAME}
