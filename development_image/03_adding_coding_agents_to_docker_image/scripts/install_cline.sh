#!/usr/bin/env bash
#
# install_cline.sh
#
# Purpose:
#   Install the Cline CLI globally via npm inside the image and verify it works.
#
# What this script does:
#   - Ensures npm is present (installed in layer 02).
#   - Installs cline globally using npm.
#   - Verifies the 'cline' command is available on PATH.
#   - Prints cline --version to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - Global npm installs typically write to /usr/local, so run as root in the Dockerfile.
#   - Node.js and npm are expected to be installed by layer 02 (setup_nodejs.sh).
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Node and npm are only in the path in interactive shells via .bashrc so here we need to add to the path
export NODE_BIN_DIR="/home/developer/programs/node/bin"
export PATH="$NODE_BIN_DIR:$PATH"

echo "[install_cline] Installing cline globally..."
npm install -g cline

echo "[install_cline] Verifying cline is on PATH and printing version..."
if ! command -v cline >/dev/null 2>&1; then
    echo "[install_cline] ERROR: 'cline' not found on PATH after installation."
    exit 1
fi

# Calling cline help to see tool installed
cline --help
echo "[install_cline] Cline CLI installed successfully."
