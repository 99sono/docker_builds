#!/usr/bin/env bash
#
# 01_A_build_and_run.sh
#
# Purpose:
#   Start a fresh test container from the already-built Layer 04 "project stubs" image.
#   This script assumes the image has already been built (e.g., via ./build.sh).
#
# Behavior:
#   - Uses image: development-level04-project-stubs:${IMAGE_VERSION:-1.0.0}
#   - Removes any pre-existing test container with the same name
#   - Starts container named dev-test-level04
#
set -euo pipefail

source ../../00_common_env.sh || true

IMAGE_VERSION="${IMAGE_VERSION:-1.0.0}"
IMAGE_NAME="development-level04-project-stubs:${IMAGE_VERSION}"
CONTAINER_NAME="${TEST_CONTAINER_NAME}"

# No build step here. We assume the image is already built (use ./build.sh beforehand).
# Validate image exists locally for a better error message.
if ! docker image inspect "${IMAGE_NAME}" >/dev/null 2>&1; then
  echo "[verify-04/01] ERROR: Image ${IMAGE_NAME} not found locally."
  echo "Run the build first, e.g.:"
  echo "  (cd .. && ./build.sh)"
  exit 1
fi

echo "[verify-04/01] Removing any existing container: ${CONTAINER_NAME} ..."
docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

echo "[verify-04/01] Starting container ${CONTAINER_NAME} from ${IMAGE_NAME} ..."
docker run -d --name "${CONTAINER_NAME}" \
  -e TZ="${TZ:-Europe/Zurich}" \
  "${IMAGE_NAME}"

echo "[verify-04/01] Waiting briefly for container to initialize ..."
sleep 3

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-04/01] ERROR: Container ${CONTAINER_NAME} is not running."
  docker logs "${CONTAINER_NAME}" || true
  exit 1
fi

echo "✅ Layer 04 image built and test container started: ${CONTAINER_NAME}"
