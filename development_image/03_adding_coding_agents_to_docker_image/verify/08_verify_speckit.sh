#!/usr/bin/env bash
#
# 08_verify_speckit.sh
#
# Purpose:
#   Verify that the 'specify' CLI (speckit) is installed and available within the Level 03 test container.
#   This script checks for the command existence and tests that it works.
#
# Behavior:
#   - Sources common env to align on naming and version.
#   - Expects the test container to be running (started by 01_A_run_built_container_entrypoint_script.sh).
#   - Fails with a non-zero exit code if verification fails.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-08/speckit] Verifying 'specify' CLI (speckit) inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "[verify-08/speckit] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
    echo "  ./01_A_run_built_container_entrypoint_script.sh"
    exit 1
fi

# The specify command should be available in the system PATH after uv tool installation
# Test that specify command is available and working

if ! docker exec "${CONTAINER_NAME}" bash -lc 'command -v specify && specify --help' >/dev/null 2>&1; then
    echo "❌ 'specify' not found on PATH inside the container or --help failed."
    echo "   Expected specify command to be available in system PATH"
    exit 1
fi

echo "✅ Speckit (specify CLI) verified successfully"
