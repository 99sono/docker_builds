#!/usr/bin/env bash
#
# 09_verify_cline.sh
#
# Purpose:
#   Verify that the 'cline' CLI is installed and available within the Level 03 test container.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-09/cline] Verifying 'cline' CLI inside container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-09/cline] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

if ! docker exec "${CONTAINER_NAME}" bash -c \
  'source /home/developer/programs/miniforge3/etc/profile.d/conda.sh && conda activate base && command -v cline && cline --help' >/dev/null 2>&1; then
    echo "❌ 'cline' not found on PATH inside the container."
    exit 1
fi

echo "✅ Cline CLI verified successfully"
