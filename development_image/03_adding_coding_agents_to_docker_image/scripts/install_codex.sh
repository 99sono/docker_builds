#!/usr/bin/env bash
#
# install_codex.sh
#
# Purpose:
#   Install the OpenAI Codex CLI globally via npm and register its RTK plugin.
#   Reference: https://developers.openai.com/codex/cli
#
# What this script does:
#   - Activates the conda base environment to get node/npm on PATH.
#   - Installs @openai/codex globally.
#   - Verifies the 'codex' command is available.
#   - Runs `rtk init -g --codex` to register the RTK plugin.
#
# Notes:
#   - The CLI requires authentication (e.g., codex login) at runtime.
#   - Node.js and npm come from the Miniforge3 base conda environment (layer 02).
#   - RTK must already be installed (install_rtk.sh runs before this script).
#
set -euo pipefail

# Activate conda base env to get node/npm on PATH
source /home/developer/programs/miniforge3/etc/profile.d/conda.sh
conda activate base

echo "[install_codex] Installing @openai/codex globally..."
npm install -g @openai/codex@latest

echo "[install_codex] Verifying codex is on PATH..."
if ! command -v codex >/dev/null 2>&1; then
    echo "[install_codex] ERROR: 'codex' not found on PATH after installation."
    exit 1
fi

codex --version
echo "[install_codex] OpenAI Codex CLI installed successfully."

# Register RTK plugin for Codex
echo "[install_codex] Registering RTK plugin for codex..."
export PATH="/home/developer/.local/bin:$PATH"
rtk init -g --codex
echo "[install_codex] RTK plugin for codex registered."
