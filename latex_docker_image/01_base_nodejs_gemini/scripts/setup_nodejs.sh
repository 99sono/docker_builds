#!/bin/bash
# Script to install Node.js in /home/developer/programs/node

# Use the version from common_env if available, otherwise default
NODE_VERSION=${NODE_VERSION:-"20.11.1"}
INSTALL_DIR="/home/developer/programs/node"
TEMP_DIR="/tmp/node-install"

echo "[setup_nodejs] Installing Node.js v${NODE_VERSION}..."

# Create temporary directory
mkdir -p "$TEMP_DIR"

# Download Node.js
curl -L "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" -o "$TEMP_DIR/node.tar.xz" || {
    echo "Error: Failed to download Node.js"
    exit 1
}

# Extract and install
mkdir -p "$INSTALL_DIR"
tar -xJf "$TEMP_DIR/node.tar.xz" -C "$INSTALL_DIR" --strip-components=1 || {
    echo "Error: Failed to extract Node.js"
    exit 1
}

# Update PATH in .bashrc
echo 'export PATH="/home/developer/programs/node/bin:$PATH"' >> /home/developer/.bashrc

# Clean up
rm -rf "$TEMP_DIR"
echo "[setup_nodejs] Node.js installed successfully in $INSTALL_DIR"
