#!/usr/bin/env bash
#
# install_opencode.sh
#
# Purpose:
#   Install the OpenCode CLI globally via npm and register its RTK plugin.
#
# What this script does:
#   - Activates the conda base environment to get node/npm on PATH.
#   - Installs opencode-ai globally using npm.
#   - Verifies the 'opencode' command is available.
#   - Runs `rtk init -g --opencode` to register the RTK plugin.
#
# Notes:
#   - Node.js and npm come from the Miniforge3 base conda environment (layer 02).
#   - RTK must already be installed (install_rtk.sh runs before this script).
#
set -euo pipefail

# Activate conda base env to get node/npm on PATH
source /home/developer/programs/miniforge3/etc/profile.d/conda.sh
conda activate base

echo "[install_opencode] Installing opencode-ai globally..."
npm install -g opencode-ai

echo "[install_opencode] Verifying opencode is on PATH..."
if ! command -v opencode >/dev/null 2>&1; then
    echo "[install_opencode] ERROR: 'opencode' not found on PATH after installation."
    exit 1
fi

opencode --version
echo "[install_opencode] OpenCode CLI installed successfully."

# Register RTK plugin for OpenCode
echo "[install_opencode] Registering RTK plugin for opencode..."
export PATH="/home/developer/.local/bin:$PATH"
rtk init -g --opencode
echo "[install_opencode] RTK plugin for opencode registered."