#!/bin/bash
echo "Building/Pulling latest images..."
# Since we use a build block, we should trigger a build
docker compose build
