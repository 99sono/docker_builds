#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the base software image
docker build \
    -t "${IMAGE_NAME_SUFFIX_BASE_SOFTWARE}:${IMAGE_VERSION}" \
    -f Dockerfile \
    .