#!/bin/bash

# Source common environment variables
source ../../00_common_env.sh

# Interactive script to enter the test dev container for manual inspection
# This script is for manual debugging and requires interactive input
echo "[manual-entry] Entering container: ${TEST_CONTAINER_NAME}"
echo "[manual-entry] Type 'exit' to return to host shell"
echo ""

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${TEST_CONTAINER_NAME}$"; then
    echo "[manual-entry] ERROR: Container ${TEST_CONTAINER_NAME} is not running."
    echo "[manual-entry] Start the container first with:"
    echo "  ./01_A_run_built_container_entrypoint_script.sh"
    exit 1
fi

exec docker exec -it "${TEST_CONTAINER_NAME}" bash
