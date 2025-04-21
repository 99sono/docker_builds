#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the project stubs image
docker build \
    -t "${IMAGE_NAME_SUFFIX_PROJECT_STUBS}:${IMAGE_VERSION}" \
    -f Dockerfile \
    .