#!/usr/bin/env bash
#
# 05_verify_openai_codex.sh
#
# Purpose:
#   Verify that the 'codex' CLI is installed and available within the Level 03 test container.
#
set -euo pipefail

source ../../00_common_env.sh

CONTAINER_NAME="${TEST_CONTAINER_NAME}"

echo "[verify-05/codex] Verifying 'codex' CLI inside container: ${CONTAINER_NAME}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-05/codex] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_run_built_container_entrypoint_script.sh"
  exit 1
fi

if ! docker exec "${CONTAINER_NAME}" bash -c \
  'source /home/developer/programs/miniforge3/etc/profile.d/conda.sh && conda activate base && command -v codex && codex --version' >/dev/null 2>&1; then
    echo "❌ 'codex' not found on PATH inside the container."
    exit 1
fi

echo "✅ OpenAI Codex CLI verified successfully"
