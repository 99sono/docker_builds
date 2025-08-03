#!/bin/bash
set -e

echo "🚀 Building Development Environment - All Layers"
echo "=============================================="

# Source common environment
source ./00_common_env.sh

# Build base software image
echo "📦 Building base software image..."
cd 01_build_base_software_image
./build.sh
cd ..

# Build development environments image
echo "📦 Building development environments image..."
cd 02_build_dev_environments_image
./build.sh
cd ..

# Build project stubs image
echo "📦 Building project stubs image..."
cd 04_project_stubs
./build.sh
cd ..

echo "✅ All images built successfully!"
echo ""
echo "Available images:"
docker images | grep development-level
