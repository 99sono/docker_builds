#!/usr/bin/env bash
#
# install_cline.sh
#
# Purpose:
#   Install the Cline CLI globally via npm and register its RTK plugin.
#
# What this script does:
#   - Activates the conda base environment to get node/npm on PATH.
#   - Installs cline globally using npm.
#   - Verifies the 'cline' command is available.
#   - Runs `rtk init --agent cline` to register the RTK plugin.
#
# Notes:
#   - Node.js and npm come from the Miniforge3 base conda environment (layer 02).
#   - RTK must already be installed (install_rtk.sh runs before this script).
#
set -euo pipefail

# Activate conda base env to get node/npm on PATH
source /home/developer/programs/miniforge3/etc/profile.d/conda.sh
conda activate base

echo "[install_cline] Installing cline globally..."
npm install -g cline

echo "[install_cline] Verifying cline is on PATH..."
if ! command -v cline >/dev/null 2>&1; then
    echo "[install_cline] ERROR: 'cline' not found on PATH after installation."
    exit 1
fi

cline --help
echo "[install_cline] Cline CLI installed successfully."

# Register RTK plugin for Cline
echo "[install_cline] Registering RTK plugin for cline..."
export PATH="/home/developer/.local/bin:$PATH"
rtk init --agent cline
echo "[install_cline] RTK plugin for cline registered."
