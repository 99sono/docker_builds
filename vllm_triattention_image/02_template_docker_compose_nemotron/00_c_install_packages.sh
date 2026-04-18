#!/bin/bash
# =============================================================================
# 00_c_install_packages.sh
# Installs required packages inside the testVllmTriAttn conda environment
# =============================================================================

# Note: We don't use set -e here because conda activate might need manual sourcing in some shells
ENV_NAME="testVllmTriAttn"

echo "📦 Installing packages into conda environment: $ENV_NAME"

# Try to activate the environment (this might fail in some shell configurations if not sourced)
# Users are encouraged to run 'conda activate' manually first
conda activate "$ENV_NAME" || echo "Please ensure you run 'conda activate $ENV_NAME' before this script."

# Install main dependencies
pip install --upgrade pip
pip install openai rich

echo ""
echo "✅ Packages installed successfully!"
echo ""
echo "You can now run the test using:"
echo "    conda activate $ENV_NAME"
echo "    python 04_test_vllm_python.py"
