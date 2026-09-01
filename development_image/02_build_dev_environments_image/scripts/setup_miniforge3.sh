#!/bin/bash
# Script to install Miniforge3 (Python + conda)
#
# Installs:
#   - Miniforge3 (conda) with Python in the base environment
#
# After this script runs, `python` and `conda` are available in
# /home/developer/programs/miniforge3/bin/ and are on PATH for all
# future interactive shells (via conda init in .bashrc).

set -euo pipefail

CONDA_HOME="/home/developer/programs/miniforge3"
INSTALLER_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
INSTALLER_PATH="/tmp/Miniforge3-Linux-x86_64.sh"

# --- 1. Download Miniforge3 installer ---
echo "[setup_miniforge3] Downloading Miniforge3 installer..."
curl -fsSL -o "$INSTALLER_PATH" "$INSTALLER_URL" || {
    echo "Error: Failed to download Miniforge3 installer"
    exit 1
}

# --- 2. Install Miniforge3 non-interactively ---
echo "[setup_miniforge3] Installing Miniforge3 to $CONDA_HOME..."
bash "$INSTALLER_PATH" -b -p "$CONDA_HOME" || {
    echo "Error: Miniforge3 installation failed"
    exit 1
}

# Clean up installer
rm -f "$INSTALLER_PATH"

# --- 3. Initialize conda for bash ---
echo "[setup_miniforge3] Initializing conda for bash..."
"$CONDA_HOME/bin/conda" init bash

# Enable auto-activation of base env in future shells
"$CONDA_HOME/bin/conda" config --set auto_activate_base true

# --- 4. Pin Python version in the base environment ---
PYTHON_VERSION="3.14.7"
echo "[setup_miniforge3] Installing Python ${PYTHON_VERSION} into base environment..."
source "$CONDA_HOME/etc/profile.d/conda.sh"
conda activate base
conda install -y "python=${PYTHON_VERSION}" || {
    echo "Error: Failed to install Python ${PYTHON_VERSION} via conda"
    exit 1
}

# --- 5. Verify installation ---
echo "[setup_miniforge3] Verifying installation..."
echo "  Python: $(python --version 2>&1)"
echo "  Conda:  $(conda --version 2>&1)"

echo "[setup_miniforge3] Setup complete."