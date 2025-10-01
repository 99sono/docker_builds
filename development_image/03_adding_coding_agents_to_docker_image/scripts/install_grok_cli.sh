#!/usr/bin/env bash
#
# install_grok_cli.sh
#
# Purpose:
#   Install the Grok CLI globally via npm inside the image and verify it works.
#   This follows the instructions from: https://grokcli.io
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs @vibe-kit/grok-cli globally.
#   - Verifies the 'grok' command is available on PATH.
#   - Prints grok --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires authentication (e.g., grok init or login) at runtime for actual API calls.
#   - Global npm installs typically write to /usr/local, so run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_grok_cli] Installing @vibe-kit/grok-cli globally..."
npm install -g @vibe-kit/grok-cli@latest

echo "[install_grok_cli] Verifying grok is on PATH and printing version..."
if ! command -v grok >/dev/null 2>&1; then
  echo "[install_grok_cli] ERROR: 'grok' not found on PATH after installation."
  exit 1
fi

grok --version
echo "[install_grok_cli] Grok CLI installed successfully."
