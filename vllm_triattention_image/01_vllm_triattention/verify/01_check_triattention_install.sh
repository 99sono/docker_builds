#!/bin/bash
# Verify that the triattention plugin is installed in the image

# Source common environment variables
source ../../00_common_env.sh

IMAGE_NAME="${IMAGE_NAME_SUFFIX_VLLM_TRIATTENTION}:${IMAGE_VERSION}"

echo "Verifying TriAttention installation in ${IMAGE_NAME}..."

# Run a temporary container and check if 'triattention' is in the pip list
# We use --entrypoint python3 because the base image entrypoint is set to start the server
if docker run --rm --entrypoint python3 "${IMAGE_NAME}" -m pip show triattention > /dev/null 2>&1; then
    echo "SUCCESS: TriAttention plugin is installed and registered."
    docker run --rm --entrypoint python3 "${IMAGE_NAME}" -m pip show triattention | grep Version
else
    echo "FAILURE: TriAttention plugin NOT found in the image."
    exit 1
fi
