#!/bin/bash
# Script to start the LaTeX CV development environment

# Create the local workspace directory if it doesn't exist
mkdir -p cv_workspace

echo "Starting LaTeX + Gemini CLI environment..."
docker compose up -d

echo "---------------------------------------------------"
echo "Environment is running in the background."
echo "Use ./03_enter_cv_dev.sh to open a terminal inside."
echo "---------------------------------------------------"
