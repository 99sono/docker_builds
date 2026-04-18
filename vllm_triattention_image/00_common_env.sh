#!/bin/bash
# Global environment variables for the vLLM TriAttention Docker images

# Base image naming suffixes
export IMAGE_NAME_SUFFIX_VLLM_TRIATTENTION="vllm-triattention"

# Version number for images
export IMAGE_VERSION="1.0.0"

# Base vLLM image
export VLLM_BASE_IMAGE="vllm/vllm-openai:latest"

# Docker Hub repository information (following project pattern)
export DOCKER_HUB_REPO_NAME="99sono/99sono-vllm-triattention"
