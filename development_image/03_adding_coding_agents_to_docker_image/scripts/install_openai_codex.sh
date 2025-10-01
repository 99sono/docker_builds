#!/usr/bin/env bash
#
# install_openai_codex.sh
#
# Purpose:
#   Install the OpenAI Codex CLI globally via npm inside the image and verify it works.
#   This follows the instructions from: https://developers.openai.com/codex/cli
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs @openai/codex globally.
#   - Verifies the 'codex' command is available on PATH.
#   - Prints codex --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires authentication (e.g., codex login) at runtime for actual API calls.
#   - Global npm installs typically write to /usr/local, so run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_openai_codex] Installing @openai/codex globally..."
npm install -g @openai/codex@latest

echo "[install_openai_codex] Verifying codex is on PATH and printing version..."
if ! command -v codex >/dev/null 2>&1; then
  echo "[install_openai_codex] ERROR: 'codex' not found on PATH after installation."
  exit 1
fi

codex --version
echo "[install_openai_codex] OpenAI Codex CLI installed successfully."
