#!/bin/bash
# Script to enter the running LaTeX CV container

CONTAINER_NAME="latex-cv-env"

if [ ! "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Error: Container $CONTAINER_NAME is not running."
    echo "Please run ./02_start_dev.sh first."
    exit 1
fi

echo "Entering $CONTAINER_NAME..."
docker exec -it "$CONTAINER_NAME" /bin/bash
