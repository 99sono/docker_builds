#!/bin/bash
set -e

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."

echo "Starting verification of LaTeX + Gemini images..."

cd "$PROJECT_ROOT/01_base_nodejs_gemini" && ./verify/01_verify_gemini.sh
cd "$PROJECT_ROOT/02_latex_env" && ./verify/01_verify_latex.sh

echo "All verifications passed."
