#!/bin/bash
source ../../00_common_env.sh

echo "=== Miniforge Verification Script ==="
echo ""
echo "Problem Context:"
echo "----------------"
echo "When running 'docker exec', the container launches a non-interactive shell that"
echo "does NOT process ~/.bashrc by default. Even manually 'source ~/.bashrc' often fails"
echo "because:"
echo "1) .bashrc may contain guards like '[ -z \"\$PS1\" ] && return' that skip execution"
echo "2) Conda's PATH modifications may not persist for subsequent commands"
echo ""
echo "Solution Approach:"
echo "-----------------"
echo "This script works around the problem by:"
echo "1) For conda: Directly sourcing conda's initialization script"
echo "   (/home/developer/programs/miniforge3/etc/profile.d/conda.sh)"
echo "2) For Python: Using the absolute path to the Miniforge-installed Python binary"
echo "   to bypass any shell initialization issues completely"
echo ""
echo "Credit:"
echo "-------"
echo "This solution was developed with assistance from DeepSeek AI (https://deepseek.com)"
echo "to resolve the non-interactive shell initialization challenges."
echo ""

echo "=== Verifying Miniforge Installation ==="

# Verify conda exists by directly sourcing conda's init script
if ! docker exec ${TEST_CONTAINER_NAME} bash -c \
  "source /home/developer/programs/miniforge3/etc/profile.d/conda.sh && conda --version"; then
    echo "❌ Miniforge not installed properly (conda command failed)"
    exit 1
fi

# Verify Python exists by using absolute path to Miniforge's Python
if ! docker exec ${TEST_CONTAINER_NAME} \
  /home/developer/programs/miniforge3/bin/python --version; then
    echo "❌ Python not available in Miniforge"
    exit 1
fi

echo "✅ Miniforge verified successfully"