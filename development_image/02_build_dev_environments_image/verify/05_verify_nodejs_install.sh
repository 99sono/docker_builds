#!/bin/bash
source ../../00_common_env.sh

echo "=== Node.js Verification Script ==="
echo ""
echo "Problem Context:"
echo "----------------"
echo "This script handles special environment challenges when verifying Node.js in Docker:"
echo "1) Non-interactive shells (from 'docker exec') ignore .bashrc initialization"
echo "2) npm has a special requirement - it's a shell script that calls 'node' via env"
echo "   (#!/usr/bin/env node) and thus requires correct PATH configuration"
echo ""
echo "Solution Approach:"
echo "-----------------"
echo "1) For Node.js: Uses direct path to binary (/home/developer/programs/node/bin/node)"
echo "2) For npm: Temporarily sets PATH to include Node's bin directory before execution"
echo "   This matches how npm expects to find its Node.js dependency"
echo ""
echo "Key Nuances:"
echo "-----------"
echo "- Unlike regular shells, we can't rely on .bashrc PATH modifications"
echo "- npm verification is special because it's a script that needs to find node"
echo "- The PATH modification is scoped only to the npm verification command"
echo ""
echo "Credit:"
echo "------"
echo "Developed with assistance from DeepSeek AI (https://deepseek.com) to solve"
echo "the Docker non-interactive shell environment challenges."
echo ""

NODE_BIN_DIR="/home/developer/programs/node/bin"

echo "=== Verifying Node.js Installation ==="

# Verify Node.js binary exists directly
if ! docker exec ${TEST_CONTAINER_NAME} ${NODE_BIN_DIR}/node --version >/dev/null 2>&1; then
    echo "❌ Node.js not found or not executable at ${NODE_BIN_DIR}/node"
    exit 1
fi

# Verify npm works with temporary PATH adjustment
if ! docker exec ${TEST_CONTAINER_NAME} bash -c \
    "export PATH=${NODE_BIN_DIR}:\$PATH && ${NODE_BIN_DIR}/npm --version" >/dev/null 2>&1; then
    echo "❌ npm found but failed to run (PATH configuration issue)"
    exit 1
fi

echo "✅ Node.js and npm verified successfully"