#!/usr/bin/env bash
#
# install_qwen_code.sh
#
# Purpose:
#   Install the Qwen Code CLI globally via npm inside the image and verify it works.
#   This follows the official instructions from:
#   https://github.com/QwenLM/qwen-code
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs @qwen-code/qwen-code globally.
#   - Verifies the 'qwen' command is available on PATH.
#   - Prints qwen --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires proper API configuration at runtime for actual API calls. This script does NOT set it,
#     it only installs and verifies the CLI binary presence.
#   - Global npm installs typically write to /usr/local, so we must run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in non-login shells via .bashrc tweaks in this project,
# so we must explicitly prepend the Node bin dir here (same convention as gemini installer).
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_qwen_code] Installing @qwen-code/qwen-code globally..."
npm install -g @qwen-code/qwen-code@latest

echo "[install_qwen_code] Verifying qwen is on PATH and printing version..."
if ! command -v qwen >/dev/null 2>&1; then
  echo "[install_qwen_code] ERROR: 'qwen' not found on PATH after installation."
  exit 1
fi

qwen --version
echo "[install_qwen_code] Qwen Code CLI installed successfully."
