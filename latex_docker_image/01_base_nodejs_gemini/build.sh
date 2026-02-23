#!/bin/bash
# Source common environment variables
source ../00_common_env.sh

echo "Building Layer 01: Base + Node.js + Gemini CLI..."

docker build 
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} 
    -t "${IMAGE_NAME_SUFFIX_LATEX_BASE}:${IMAGE_VERSION}" 
    -f Dockerfile 
    .
