#!/usr/bin/env bash
#
# install_gemini_cli.sh
#
# Purpose:
#   Install the Google Gemini CLI globally via npm inside the image and verify it works.
#   This follows the official instructions from:
#   https://github.com/google-gemini/gemini-cli
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs @google/gemini-cli globally.
#   - Verifies the 'gemini' command is available on PATH.
#   - Prints gemini --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires GEMINI_API_KEY at runtime for actual API calls. This script does NOT set it,
#     it only installs and verifies the CLI binary presence.
#   - Global npm installs typically write to /usr/local, so we must run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

# install gemini cli
# see https://github.com/google-gemini/gemini-cli
echo "[install_gemini_cli] Installing @google/gemini-cli globally..."
npm install -g @google/gemini-cli@latest

echo "[install_gemini_cli] Verifying gemini is on PATH and printing version..."
if ! command -v gemini >/dev/null 2>&1; then
  echo "[install_gemini_cli] ERROR: 'gemini' not found on PATH after installation."
  exit 1
fi

gemini --version
echo "[install_gemini_cli] Gemini CLI installed successfully."
