#!/bin/bash
# Source common environment variables
source ../00_common_env.sh

echo "Building Layer 02: LaTeX Environment..."

docker build 
    --build-arg IMAGE_VERSION=${IMAGE_VERSION} 
    -t "${IMAGE_NAME_SUFFIX_LATEX_ENV}:${IMAGE_VERSION}" 
    -f Dockerfile 
    .
