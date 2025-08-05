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

CONTAINER_NAME="dev-test-level03"

echo "[verify-03/gemini] Verifying 'gemini' CLI inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-03/gemini] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

set +e
docker exec "${CONTAINER_NAME}" bash -lc 'command -v gemini >/dev/null 2>&1'
CMD_STATUS=$?
set -e

if [ "$CMD_STATUS" -ne 0 ]; then
  echo "[verify-03/gemini] ERROR: 'gemini' command not found on PATH inside the container."
  exit 2
fi

# Show the path and version for clarity
GEM_PATH=$(docker exec "${CONTAINER_NAME}" bash -lc 'command -v gemini')
GEM_VER=$(docker exec "${CONTAINER_NAME}" bash -lc 'gemini --version 2>/dev/null || true')

echo "[verify-03/gemini] gemini path: ${GEM_PATH}"
if [ -n "${GEM_VER}" ]; then
  echo "[verify-03/gemini] gemini version: ${GEM_VER}"
else
  echo "[verify-03/gemini] WARNING: 'gemini --version' did not return a version string."
fi

echo "[verify-03/gemini] Verification PASSED."
