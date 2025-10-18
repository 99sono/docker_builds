#!/usr/bin/env bash
#
# 01_A_run_built_container_entrypoint_script.sh
#
# Purpose:
#   Start a detached test container from the Layer 03 image so that we can run verification steps.
#   This mirrors the style used in prior layers' verify scripts.
#
# Behavior:
#   - Sources common env to get IMAGE_VERSION and image name suffixes.
#   - Creates/uses a deterministic container name for easy follow-up exec/cleanup.
#   - Runs the container detached, relying on the inherited entrypoint from Level 01.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"
IMAGE_TAG="${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"

echo "[verify-03/run] Using image: ${IMAGE_TAG}"
echo "[verify-03/run] Container name: ${CONTAINER_NAME}"

# If a container with this name already exists, remove it to ensure a clean run.
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-03/run] Removing existing container: ${CONTAINER_NAME}"
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

# Run the container detached. We expose SSH port for consistency, but it's not required for gemini verification.
docker run -d --name "${CONTAINER_NAME}" -p 2222:22 "${IMAGE_TAG}"

echo "[verify-03/run] Container started: ${CONTAINER_NAME}"
docker ps --filter "name=${CONTAINER_NAME}"
