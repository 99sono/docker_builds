#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the development environments image
docker build \
    --build-arg IMAGE_VERSION=${IMAGE_VERSION} \
    -t "${IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:${IMAGE_VERSION}" \
    -f Dockerfile \
    .