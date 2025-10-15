#!/bin/bash

# Tag the latest (final) created image before publishing to Docker Hub
#
# This script tags the final development image (development-level04-project-stubs:1.0.0)
# with the Docker Hub repository name and snapshot tag for publishing

set -e

# Source environment variables
source ../00_common_env.sh

echo "🏷️ Tagging final development image for Docker Hub publishing"
echo "============================================="
echo "Source image: ${IMAGE_NAME_SUFFIX_PROJECT_STUBS}:${IMAGE_VERSION}"
echo "Target tag: ${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"
echo ""

# Tag the final image for Docker Hub
docker tag "${IMAGE_NAME_SUFFIX_PROJECT_STUBS}:${IMAGE_VERSION}" "${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"

echo "✅ Image tagged successfully!"
echo "Ready for publishing with: docker push ${DOCKER_HUB_REPO_NAME}:${DOCKER_HUB_TAG}"
