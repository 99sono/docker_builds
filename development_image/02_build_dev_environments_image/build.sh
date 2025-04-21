#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the development environments image
docker build \
    -t "${IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:${IMAGE_VERSION}" \
    -f Dockerfile \
    .