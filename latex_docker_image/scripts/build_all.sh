#!/bin/bash
set -e

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."

echo "Starting full build of LaTeX + Gemini images..."

cd "$PROJECT_ROOT/01_base_nodejs_gemini" && ./build.sh
cd "$PROJECT_ROOT/02_latex_env" && ./build.sh

echo "All images built successfully."
