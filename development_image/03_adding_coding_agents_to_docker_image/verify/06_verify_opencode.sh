#!/usr/bin/env bash
#
# 06_verify_opencode.sh
#
# Purpose:
#   Verify that the 'opencode' CLI is installed and available within the Level 03 test container.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-06/opencode] Verifying 'opencode' CLI inside container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-06/opencode] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

if ! docker exec "${CONTAINER_NAME}" bash -c \
  'source /home/developer/programs/miniforge3/etc/profile.d/conda.sh && conda activate base && command -v opencode && opencode --version' >/dev/null 2>&1; then
    echo "❌ 'opencode' not found on PATH inside the container."
    exit 1
fi

echo "✅ OpenCode CLI verified successfully"
