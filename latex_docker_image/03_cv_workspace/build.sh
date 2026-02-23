#!/bin/bash
# Source common environment variables
source ../00_common_env.sh

echo "Building Layer 03: Workspace & Templates..."

docker build \
    --build-arg IMAGE_VERSION=${IMAGE_VERSION} \
    -t "latex-level03-workspace:${IMAGE_VERSION}" \
    -f Dockerfile \
    .
