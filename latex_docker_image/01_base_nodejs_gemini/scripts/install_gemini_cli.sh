#!/usr/bin/env bash
# install_gemini_cli.sh

set -euo pipefail

# Add Node to path for the installation
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_gemini_cli] Installing @google/gemini-cli globally..."
npm install -g @google/gemini-cli@latest

echo "[install_gemini_cli] Verifying gemini is on PATH..."
if ! command -v gemini >/dev/null 2>&1; then
  echo "[install_gemini_cli] ERROR: 'gemini' not found on PATH."
  exit 1
fi

gemini --version
echo "[install_gemini_cli] Gemini CLI installed successfully."
