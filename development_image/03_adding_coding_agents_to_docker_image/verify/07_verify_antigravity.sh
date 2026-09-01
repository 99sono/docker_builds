#!/usr/bin/env bash
#
# 07_verify_antigravity.sh
#
# Purpose:
#   Verify that the 'agy' (Antigravity) CLI binary is installed and available.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-07/antigravity] Verifying 'agy' binary inside container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-07/antigravity] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

# Antigravity is a native binary at /home/developer/.local/bin/agy
if ! docker exec "${CONTAINER_NAME}" test -x /home/developer/.local/bin/agy; then
    echo "❌ 'agy' binary not found at /home/developer/.local/bin/agy"
    exit 1
fi

echo "✅ Antigravity CLI (agy) verified successfully"
