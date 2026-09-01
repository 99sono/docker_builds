#!/usr/bin/env bash
#
# install_rtk.sh
#
# Purpose:
#   Install the RTK (Retool) CLI natively and verify it works.
#   RTK is a shared prerequisite for all coding agents in this layer.
#
# What this script does:
#   - Downloads and runs the RTK installer script.
#   - Verifies the 'rtk' binary is available.
#   - Prints rtk version to fail fast during the Docker build.
#
# Notes:
#   - RTK installs to /home/developer/.local/bin/rtk (native binary, no Node.js needed).
#   - Must be installed BEFORE the coding agents so their `rtk init` steps can run.
#
set -euo pipefail

echo "[install_rtk] Installing RTK via official installer..."
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

RTK_BIN="/home/developer/.local/bin/rtk"

echo "[install_rtk] Verifying rtk binary exists..."
if [ ! -x "${RTK_BIN}" ]; then
    echo "[install_rtk] ERROR: 'rtk' binary not found at ${RTK_BIN}"
    exit 1
fi

echo "[install_rtk] RTK version:"
"${RTK_BIN}" --version

echo "[install_rtk] RTK installed successfully."