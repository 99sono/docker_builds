#!/usr/bin/env bash
#
# 02_check_container_access.sh
#
# Purpose:
#   Non-interactive script to verify that the test container is accessible via docker exec.
#   This script is used in automated verification and doesn't require manual input.
#
# Behavior:
#   - Sources common environment variables for consistent configuration.
#   - Verifies the test container is running.
#   - Tests that docker exec can execute commands in the container.
#   - Exits with success/failure status for automated testing.
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[check-access] Verifying docker exec access to container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "[check-access] ERROR: Container ${CONTAINER_NAME} is not running."
    echo "[check-access] Start the container first with:"
    echo "  ./01_A_build_and_run.sh"
    exit 1
fi

# Test that we can execute a simple command in the container
echo "[check-access] Testing basic command execution..."
if docker exec "${CONTAINER_NAME}" echo "Container is accessible"; then
    echo "[check-access] ✅ Container access test passed"
else
    echo "[check-access] ❌ Container access test failed"
    exit 1
fi

echo "[check-access] ✅ Container access verification completed successfully"
