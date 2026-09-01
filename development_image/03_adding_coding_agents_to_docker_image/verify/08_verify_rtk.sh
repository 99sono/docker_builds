#!/usr/bin/env bash
#
# 08_verify_rtk.sh
#
# Purpose:
#   Verify that the 'rtk' binary is installed and available.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-08/rtk] Verifying 'rtk' binary inside container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-08/rtk] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

# RTK is a native binary at /home/developer/.local/bin/rtk
if ! docker exec "${CONTAINER_NAME}" test -x /home/developer/.local/bin/rtk; then
    echo "❌ 'rtk' binary not found at /home/developer/.local/bin/rtk"
    exit 1
fi

echo "✅ RTK (rtk) verified successfully"
