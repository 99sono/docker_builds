#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the project stubs image
docker build \
    --build-arg IMAGE_VERSION=${IMAGE_VERSION} \
    -t "${IMAGE_NAME_SUFFIX_PROJECT_STUBS}:${IMAGE_VERSION}" \
    -f Dockerfile \
    .