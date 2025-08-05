#!/usr/bin/env bash
#
# build.sh (Layer 03: Coding Agents)
#
# Purpose:
#   Build the Level 03 image that adds coding agents tooling (initially the Gemini CLI)
#   on top of the Level 02 "dev environments" image.
#
# Conventions & Inspirations:
#   Mirrors the structure and simplicity of:
#   - development_image/02_build_dev_environments_image/build.sh
#   Uses the same IMAGE_VERSION build-arg and tagging approach via ../00_common_env.sh.
#
# Usage:
#   ./build.sh
#
# Outcome:
#   Produces a Docker image tagged as:
#   "${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Source common environment variables (provides IMAGE_VERSION and image suffixes)
# Expected variables (from ../00_common_env.sh):
#   IMAGE_VERSION
#   IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS="development-level02-dev-environments"
#   IMAGE_NAME_SUFFIX_CODING_AGENTS="development-level03-coding-agents"
source ../00_common_env.sh

echo "[build-03] Building Coding Agents image (Layer 03)"
echo "[build-03] IMAGE_VERSION=${IMAGE_VERSION}"
echo "[build-03] BASE (Layer 02) image tag: ${IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS}:${IMAGE_VERSION}"
echo "[build-03] Target (Layer 03) image tag: ${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"

# Build the Coding Agents image.
# The Dockerfile uses:
#   ARG IMAGE_VERSION
# and:
#   FROM development-level02-dev-environments:${IMAGE_VERSION}
#
# We pass --build-arg IMAGE_VERSION to align the base and target tags.
docker build \
  --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
  -t "${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}" \
  -f Dockerfile \
  .

echo "[build-03] Build completed: ${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}"
