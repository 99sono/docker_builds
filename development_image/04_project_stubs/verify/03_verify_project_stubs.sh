#!/usr/bin/env bash
#
# 03_verify_project_stubs.sh
#
# Purpose:
#   Verify that Layer 04 populated the expected project stubs inside the container.
#   Checks presence of Java/Node/Python dummy projects and performs lightweight sanity checks.
#
# Behavior:
#   - Ensures the test container is running.
#   - Asserts the existence of key stub folders/files created by scripts/setup_projects.sh.
#   - Performs minimal tool checks (java/javac, node, python) and lists project contents.
#
set -euo pipefail

source ../../00_common_env.sh || true

CONTAINER_NAME="dev-test-level04"

echo "[verify-04/03] Verifying project stubs inside container: ${CONTAINER_NAME}"

# Ensure the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[verify-04/03] ERROR: Container ${CONTAINER_NAME} is not running. Start it first:"
  echo "  ./01_A_build_and_run.sh"
  exit 1
fi

# Expected base workspace path created by setup_projects.sh
WORKSPACE_BASE="/home/developer/dev"

# Paths to verify
JAVA_P1="${WORKSPACE_BASE}/java/dummy_java_project01"
JAVA_P2="${WORKSPACE_BASE}/java/dummy_java_project02"
NODE_P1="${WORKSPACE_BASE}/node/dummy_node_project01"
NODE_P2="${WORKSPACE_BASE}/node/dummy_node_project02"
PY_P1="${WORKSPACE_BASE}/python/dummy_python_project01"
PY_P2="${WORKSPACE_BASE}/python/dummy_python_project02"

# Helper to exec a command inside container with bash -lc
exec_c() {
  docker exec "${CONTAINER_NAME}" bash -lc "$*"
}

# 1) Check workspace base exists
echo "[verify-04/03] Checking workspace base: ${WORKSPACE_BASE}"
exec_c "test -d '${WORKSPACE_BASE}' && ls -la '${WORKSPACE_BASE}'"

# 2) Verify Java projects exist and have minimal files
echo "[verify-04/03] Checking Java stubs..."
for P in "${JAVA_P1}" "${JAVA_P2}"; do
  exec_c "test -d '${P}/src/main/java' && test -f '${P}/pom.xml' && ls -la '${P}' '${P}/src/main/java' || (echo 'Missing Java stub structure at ${P}' && exit 1)"
done

# 3) Verify Node projects exist and have minimal files
echo "[verify-04/03] Checking Node stubs..."
for P in "${NODE_P1}" "${NODE_P2}"; do
  exec_c "test -d '${P}' && test -f '${P}/package.json' && test -f '${P}/index.js' && ls -la '${P}' || (echo 'Missing Node stub structure at ${P}' && exit 1)"
done

# 4) Verify Python projects exist and have minimal files
echo "[verify-04/03] Checking Python stubs..."
for P in "${PY_P1}" "${PY_P2}"; do
  exec_c "test -d '${P}' && test -f '${P}/requirements.txt' && test -f '${P}/main.py' && ls -la '${P}' || (echo 'Missing Python stub structure at ${P}' && exit 1)"
done

# 5) Light tool sanity checks
echo "[verify-04/03] Toolchain sanity checks (inside container)..."
# Java
exec_c "command -v java && java -version"
exec_c "command -v javac && javac -version"
# Node
# Node may be available via /home/developer/programs/node/bin, prepend PATH for safety
exec_c 'export NODE_BIN_DIR="/home/developer/programs/node/bin"; export PATH="$NODE_BIN_DIR:$PATH"; command -v node && node --version'
# Python
exec_c "command -v python && python --version || (command -v python3 && python3 --version)"

echo "✅ Project stubs verified successfully in container ${CONTAINER_NAME}"
