#!/bin/bash
# Script to install Miniforge3 for Python

INSTALL_DIR="/home/developer/programs/miniforge3"
INSTALLER_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
INSTALLER_PATH="/tmp/Miniforge3-Linux-x86_64.sh"

# Download Miniforge3 installer
curl -L -o "$INSTALLER_PATH" "$INSTALLER_URL" || {
    echo "Error: Failed to download Miniforge3 installer"
    exit 1
}

# Install Miniforge3 non-interactively
bash "$INSTALLER_PATH" -b -p "$INSTALL_DIR" || {
    echo "Error: Miniforge3 installation failed"
    exit 1
}

# Initialize Miniforge3
"$INSTALL_DIR/bin/conda" init bash || {
    echo "Error: Failed to initialize Miniforge3"
    exit 1
}

# Clean up
rm -f "$INSTALLER_PATH"

# Update .bashrc to activate Miniforge3
echo "source $INSTALL_DIR/etc/profile.d/conda.sh" >> /home/developer/.bashrc
echo "conda activate base" >> /home/developer/.bashrc