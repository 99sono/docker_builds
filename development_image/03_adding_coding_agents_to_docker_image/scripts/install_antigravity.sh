#!/usr/bin/env bash
#
# install_antigravity.sh
#
# Purpose:
#   Install the Antigravity CLI natively and register its RTK plugin.
#
# What this script does:
#   - Downloads and runs the Antigravity installer script.
#   - Verifies the 'agy' binary is available at /home/developer/.local/bin/agy.
#   - Runs `rtk init --agent antigravity` to register the RTK plugin.
#
# Notes:
#   - Antigravity is a native binary (no Node.js needed).
#   - Installs to /home/developer/.local/bin/agy.
#   - RTK must already be installed (install_rtk.sh runs before this script).
#
set -euo pipefail

echo "[install_antigravity] Installing Antigravity CLI via official installer..."
curl -fsSL https://antigravity.google/cli/install.sh | bash

AGY_BIN="/home/developer/.local/bin/agy"

echo "[install_antigravity] Verifying agy binary exists..."
if [ ! -x "${AGY_BIN}" ]; then
    echo "[install_antigravity] ERROR: 'agy' binary not found at ${AGY_BIN}"
    exit 1
fi

echo "[install_antigravity] Antigravity CLI installed successfully."

# Register RTK plugin for Antigravity
echo "[install_antigravity] Registering RTK plugin for antigravity..."
export PATH="/home/developer/.local/bin:$PATH"
rtk init --agent antigravity
echo "[install_antigravity] RTK plugin for antigravity registered."