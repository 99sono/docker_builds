#!/usr/bin/env bash
#
# 02_enter_test_dev_container.sh
#
# Purpose:
#   Convenience script to enter the running Layer 04 test container.
#
set -euo pipefail

source ../../00_common_env.sh || true

CONTAINER_NAME="dev-test-level04"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-04/02] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_build_and_run.sh"
  exit 1
fi

echo "[verify-04/02] Entering container ${CONTAINER_NAME} ..."
docker exec -it "${CONTAINER_NAME}" bash
