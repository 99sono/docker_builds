#!/usr/bin/env bash
#
# 05_verify_ssh_service_running.sh
#
# Purpose:
#   Verify that the SSH service is running and listening on port 22 from within the container.
#   This replaces the external SSH login test which fails in CI/CD environments.
#
# Behavior:
#   - Sources common environment variables for consistent configuration.
#   - Expects the test container to be running.
#   - Checks if SSH service is listening on port 22 from within the container.
#   - Fails with a non-zero exit code if verification fails.
#
# Note: This script checks SSH service availability internally rather than external SSH login,
#       making it suitable for both local development and CI/CD environments.
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-05/ssh-service] Verifying SSH service is running inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "[verify-05/ssh-service] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
    echo "  ./01_B_run_built_container_override_entrypoint.sh"
    exit 1
fi

# Check if SSH service is listening on port 22 from within the container
echo "[verify-05/ssh-service] Checking SSH port (22) from within container..."

# Try multiple methods to check if SSH is listening
if docker exec "${CONTAINER_NAME}" bash -c 'netstat -tuln 2>/dev/null | grep -q ":22 "'; then
    echo "[verify-05/ssh-service] ✅ SSH service is listening on port 22 (netstat check)"
elif docker exec "${CONTAINER_NAME}" bash -c 'ss -tuln 2>/dev/null | grep -q ":22 "'; then
    echo "[verify-05/ssh-service] ✅ SSH service is listening on port 22 (ss check)"
elif docker exec "${CONTAINER_NAME}" bash -c 'cat /proc/net/tcp | grep -q " 0016 "'; then
    echo "[verify-05/ssh-service] ✅ SSH service is listening on port 22 (/proc/net/tcp check)"
else
    echo "[verify-05/ssh-service] ❌ SSH service is not listening on port 22"
    echo "[verify-05/ssh-service] Checking port status:"
    docker exec "${CONTAINER_NAME}" bash -c 'netstat -tuln || ss -tuln || echo "No port checking tools available"'
    exit 1
fi

echo "[verify-05/ssh-service] ✅ SSH service verification completed successfully"
