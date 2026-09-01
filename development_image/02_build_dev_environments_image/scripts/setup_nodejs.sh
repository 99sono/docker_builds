#!/bin/bash
# Script to install Node.js via conda into the Miniforge3 base environment.
#
# Prerequisite:
#   - Miniforge3 must already be installed (setup_miniforge3.sh runs first).
#
# Installs:
#   - Node.js 24.19 into the conda base environment.
#
# After this script runs, `node` and `npm` are available in
# /home/developer/programs/miniforge3/bin/ alongside python.

set -euo pipefail

CONDA_HOME="/home/developer/programs/miniforge3"
NODEJS_VERSION="24.19"

# Activate conda (required because Docker RUN does not source .bashrc)
source "$CONDA_HOME/etc/profile.d/conda.sh"
conda activate base

# Install Node.js via conda
echo "[setup_nodejs] Installing Node.js ${NODEJS_VERSION} via conda..."
conda install -y "nodejs=${NODEJS_VERSION}" || {
    echo "Error: Failed to install Node.js via conda"
    exit 1
}

# Verify installation
echo "[setup_nodejs] Verifying installation..."
echo "  Node: $(node --version 2>&1)"
echo "  NPM:  $(npm --version 2>&1)"

echo "[setup_nodejs] Setup complete."