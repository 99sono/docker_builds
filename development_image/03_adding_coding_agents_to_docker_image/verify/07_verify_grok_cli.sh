#!/usr/bin/env bash
#
# 07_verify_grok_cli.sh
#
# Purpose:
#   Verify that the 'grok' CLI is installed and available within the Level 03 test container.
#   This script checks for the command existence and prints its version.
#
# Behavior:
#   - Sources common env to align on naming and version.
#   - Expects the test container to be running (started by 01_A_run_built_container_entrypoint_script.sh).
#   - Fails with a non-zero exit code if verification fails.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="dev-test-level03"

echo "[verify-07/grok] Verifying 'grok' CLI inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-07/grok] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"

if ! docker exec "${CONTAINER_NAME}" bash -lc 'export NODE_BIN_DIR="/home/developer/programs/node/bin"; export PATH="$NODE_BIN_DIR:$PATH"; command -v grok && grok --version' >/dev/null 2>&1; then
    echo "❌ 'grok' not found on PATH inside the container after exporting NODE_BIN_DIR."
    exit 1
fi

echo "✅ Grok CLI verified successfully"
