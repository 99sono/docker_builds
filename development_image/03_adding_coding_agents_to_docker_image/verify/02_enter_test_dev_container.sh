#!/usr/bin/env bash
#
# 02_enter_test_dev_container.sh
#
# Purpose:
#   Enter the running Level 03 test container for manual inspection.
#   Mirrors style from previous layers' verify scripts.
#
# Behavior:
#   - Sources common env to align on naming.
#   - Uses a deterministic container name created by 01_A_run_built_container_entrypoint_script.sh.
#   - Opens an interactive bash shell inside the container.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="dev-test-level03"

echo "[verify-03/enter] Attempting to enter container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-03/enter] ERROR: Container ${CONTAINER_NAME} is not running. Start it first with:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

exec docker exec -it "${CONTAINER_NAME}" bash
