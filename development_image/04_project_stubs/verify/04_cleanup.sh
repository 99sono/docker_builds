#!/usr/bin/env bash
#
# 04_cleanup.sh
#
# Purpose:
#   Stop and remove the Layer 04 test container to keep the environment clean.
#
set -euo pipefail

source ../../00_common_env.sh || true

CONTAINER_NAME="dev-test-level04"

echo "[verify-04/04] Cleaning up container: ${CONTAINER_NAME}"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
  echo "✅ Removed container ${CONTAINER_NAME}"
else
  echo "[verify-04/04] No container named ${CONTAINER_NAME} found. Nothing to clean."
fi
