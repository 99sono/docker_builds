#!/usr/bin/env bash
#
# install_claude_code.sh
#
# Purpose:
#   Install the Claude Code CLI globally via npm inside the image and verify it works.
#   This follows the instructions from the Anthropic documentation.
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs @anthropic-ai/claude-code globally.
#   - Verifies the 'claude' command is available on PATH.
#   - Prints claude --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires ANTHROPIC_API_KEY at runtime for actual API calls.
#   - Global npm installs typically write to /usr/local, so run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_claude_code] Installing @anthropic-ai/claude-code globally..."
npm install -g @anthropic-ai/claude-code@latest

echo "[install_claude_code] Verifying claude is on PATH and printing version..."
if ! command -v claude >/dev/null 2>&1; then
  echo "[install_claude_code] ERROR: 'claude' not found on PATH after installation."
  exit 1
fi

claude --version
echo "[install_claude_code] Claude Code CLI installed successfully."
