#!/bin/bash
# Script to build all images in the vllm_triattention_image component

# Set script to exit on any error
set -e

echo "Starting build process for vllm_triattention_image..."

# 01. Build vLLM TriAttention Image
cd ../01_vllm_triattention
./build.sh

echo "All images in vllm_triattention_image built successfully."
