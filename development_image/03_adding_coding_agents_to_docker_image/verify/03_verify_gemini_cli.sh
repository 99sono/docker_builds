#!/usr/bin/env bash
#
# 03_verify_gemini_cli.sh
#
# Purpose:
#   Verify that the 'gemini' CLI is installed and available within the Level 03 test container.
#   This script checks for the command existence and prints its version.
#
# Behavior:
#   - Sources common env to align on naming and version.
#   - Expects the test container to be running (started by 01_A_run_built_container_entrypoint_script.sh).
#   - Fails with a non-zero exit code if verification fails.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-03/gemini] Verifying 'gemini' CLI inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-03/gemini] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi


# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"

# The gemini program is supposed to be found at:
# gemini: /home/developer/programs/node/bin/gemini

# Ensure Node is on PATH inside the container and then verify both node and gemini.
# Use bash -lc so exports take effect in the exec'd shell.
echo docker exec "${CONTAINER_NAME}" bash -lc 'export NODE_BIN_DIR="/home/developer/programs/node/bin"; export PATH="$NODE_BIN_DIR:$PATH"; command -v node && node --version && command -v gemini && gemini --version'
if ! docker exec "${CONTAINER_NAME}" bash -lc 'export NODE_BIN_DIR="/home/developer/programs/node/bin"; export PATH="$NODE_BIN_DIR:$PATH"; command -v node && node --version && command -v gemini && gemini --version' >/dev/null 2>&1; then
    echo "❌ Either node or gemini not found on PATH inside the container after exporting NODE_BIN_DIR."
    echo "   Tried with NODE_BIN_DIR=/home/developer/programs/node/bin"
    exit 1
fi


echo "✅ Gemini coding agent verified successfully"
