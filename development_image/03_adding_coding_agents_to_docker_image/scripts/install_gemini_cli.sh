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

echo "[install_gemini_cli] Verifying npm presence..."
if ! command -v npm >/dev/null 2>&1; then
  echo "[install_gemini_cli] ERROR: npm is not available. Ensure layer 02 installed Node.js/npm." >&2
  exit 1
fi

echo "[install_gemini_cli] npm version: $(npm --version || echo 'unknown')"
echo "[install_gemini_cli] node version: $(node --version || echo 'unknown')"

echo "[install_gemini_cli] Installing @google/gemini-cli globally..."
npm install -g @google/gemini-cli

echo "[install_gemini_cli] Validating installation..."
if ! command -v gemini >/dev/null 2>&1; then
  echo "[install_gemini_cli] ERROR: 'gemini' command not found on PATH after install." >&2
  echo "[install_gemini_cli] npm global bin: $(npm bin -g || true)"
  exit 1
fi

echo "[install_gemini_cli] gemini binary path: $(command -v gemini)"
echo "[install_gemini_cli] gemini version: $(gemini --version || echo 'unknown')"

echo "[install_gemini_cli] Installation successful."
