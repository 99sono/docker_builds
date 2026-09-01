#!/bin/bash
# Start the development container using docker compose

set -e

# Source environment variables if available
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

echo "=== Starting Development Container ==="

docker compose up -d

echo ""
echo "✅ Container started."
echo ""
echo "Next steps:"
echo "1. Connect via SSH:  ssh -p 2222 developer@localhost"
echo "   Or interactively: ./03_enter_container.sh"
