#!/usr/bin/env bash
#
# install_speckit.sh
#
# Purpose:
#   Install the Speckit (specify-cli) tool globally via uv inside the image and verify it works.
#   This follows the installation method from: https://github.com/github/spec-kit
#
# What this script does:
#   - Installs uv package manager using pip.
#   - Installs specify-cli using uv tool at system level.
#   - Verifies the 'specify' command is available on PATH.
#   - Tests specify --help to fail fast during the Docker build if installation is broken.
#
# Notes:
#   - The CLI requires uv for package management and Python 3.11+.
#   - Python and pip are expected to be installed by layer 02.
#   - The tool will be available in system PATH after installation.
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

echo "[install_speckit] Installing uv package manager..."

# Install uv using pip (Python is available from layer 02)
# Need to ensure pip is available in PATH during Docker build
export PATH="/home/developer/programs/miniforge3/bin:$PATH"
pip install uv

# Install specify-cli using uv tool at system level
echo "[install_speckit] Installing specify-cli globally..."
# Ensure uv is in PATH after installation
export PATH="/home/developer/.local/bin:$PATH"
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Verify specify is on PATH and working
echo "[install_speckit] Verifying specify is on PATH and testing functionality..."
if ! command -v specify >/dev/null 2>&1; then
    echo "[install_speckit] ERROR: 'specify' not found on PATH after installation."
    exit 1
fi

# Test that specify --help works (since --version doesn't exist)
specify --help >/dev/null 2>&1

echo "[install_speckit] Speckit (specify-cli) installed successfully."
echo "[install_speckit] Installation completed. The 'specify' command is now available."
