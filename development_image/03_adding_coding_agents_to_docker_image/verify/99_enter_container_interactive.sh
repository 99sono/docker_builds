#!/usr/bin/env bash
#
# 99_enter_container_interactive.sh
#
# Purpose:
#   Interactive script to enter the running Level 03 test container for manual inspection.
#   This script provides the convenient interactive entry functionality for debugging.
#
# Behavior:
#   - Sources common environment variables for consistent configuration.
#   - Checks if the test container is running.
#   - Opens an interactive bash shell inside the container.
#   - For use during manual debugging and inspection.
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[interactive-entry] Attempting to enter container: ${CONTAINER_NAME}"
echo "[interactive-entry] Use 'exit' or Ctrl+D to return to host shell"
echo ""

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "[interactive-entry] ERROR: Container ${CONTAINER_NAME} is not running."
    echo "[interactive-entry] Start the container first with:"
    echo "  ./01_A_run_built_container_entrypoint_script.sh"
    exit 1
fi

echo "[interactive-entry] Entering container ${CONTAINER_NAME}..."
exec docker exec -it "${CONTAINER_NAME}" bash
