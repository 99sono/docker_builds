#!/usr/bin/env bash
#
# build.sh (Layer 03: Coding Agents)
#
# Purpose:
#   Build the Level 03 image that adds coding agents tooling (Cline, OpenCode,
#   Antigravity, OpenAI Codex + RTK) on top of the Level 02 "dev environments" image.
#
# Usage:
#   ./build.sh
#
# Outcome:
#   Produces a Docker image tagged as:
#   "${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"
#
set -euo pipefail

# Source common environment variables
source ../00_common_env.sh

echo "[build-03] Building Coding Agents image (Layer 03)"
echo "[build-03] IMAGE_VERSION=${IMAGE_VERSION}"
echo "[build-03] BASE (Layer 02) image tag: ${IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:${IMAGE_VERSION}"
echo "[build-03] Target (Layer 03) image tag: ${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"

docker build \
  --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
  -t "${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}" \
  -f Dockerfile \
  .

echo "[build-03] Build completed: ${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"
