#!/bin/bash
set -e

echo "🔍 Verifying Development Environment"
echo "=================================="

# Source common environment
source ./00_common_env.sh

# Verify base image
echo "🔍 Verifying base software image..."
cd 01_build_base_software_image/verify
./01_A_run_built_container_entrypoint_script.sh
./05_verify_ssh_login_possible.sh
cd ../../

# Verify development environments
echo "🔍 Verifying development environments..."
cd 02_build_dev_environments_image/verify
./03_verify_java_install.sh
./04_verify_miniforge_install.sh
./05_verify_nodejs_install.sh
cd ../../

# Run comprehensive verification
echo "🔍 Running comprehensive verification..."
./scripts/03_verify_installations.sh

echo "✅ All verifications passed!"
