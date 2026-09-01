#!/bin/bash
source ../../00_common_env.sh

echo "=== Verifying Node.js Installation ==="
echo ""
echo "Context:"
echo "--------"
echo "Node.js is installed via conda into the Miniforge3 base environment."
echo "The binary lives at /home/developer/programs/miniforge3/bin/node."
echo "We source conda.sh and activate the base env to get node/npm on PATH."
echo ""

CONDA_HOME="/home/developer/programs/miniforge3"

# Verify Node.js via conda environment
if ! docker exec ${TEST_CONTAINER_NAME} bash -c \
    "source ${CONDA_HOME}/etc/profile.d/conda.sh && conda activate base && node --version" >/dev/null 2>&1; then
    echo "❌ Node.js not found in conda environment"
    exit 1
fi

# Verify npm works
if ! docker exec ${TEST_CONTAINER_NAME} bash -c \
    "source ${CONDA_HOME}/etc/profile.d/conda.sh && conda activate base && npm --version" >/dev/null 2>&1; then
    echo "❌ npm not found in conda environment"
    exit 1
fi

echo "✅ Node.js and npm verified successfully (via conda)"