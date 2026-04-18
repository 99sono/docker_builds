#!/bin/bash

# Source common environment variables
source ../00_common_env.sh

# Build the vLLM TriAttention image
echo "Building ${IMAGE_NAME_SUFFIX_VLLM_TRIATTENTION}:${IMAGE_VERSION}..."

docker build \
    --build-arg VLLM_BASE_IMAGE=${VLLM_BASE_IMAGE} \
    -t "${IMAGE_NAME_SUFFIX_VLLM_TRIATTENTION}:${IMAGE_VERSION}" \
    -t "${IMAGE_NAME_SUFFIX_VLLM_TRIATTENTION}:latest" \
    -f Dockerfile \
    .
