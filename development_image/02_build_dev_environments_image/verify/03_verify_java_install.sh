#!/bin/bash
source ../../00_common_env.sh


echo "=== Verifying Java Installation ==="

# Verify Java exists and version
if ! docker exec ${TEST_CONTAINER_NAME} java -version; then
    echo "❌ Java not found!"
    exit 1
fi

# Check for correct Java version
# Illustration of possible output when inside of the container:
# developer@container:~$ java -version
# openjdk version "21.0.12" 2026-07-21
# OpenJDK Runtime Environment (build 21.0.12+8-1-24.04-Ubuntu)
# OpenJDK 64-Bit Server VM (build 21.0.12+8-1-24.04-Ubuntu, mixed mode, sharing)
if ! docker exec ${TEST_CONTAINER_NAME} java -version 2>&1 | grep -i "openjdk version \"21"; then
    echo "❌ Wrong Java version installed"
    exit 1
fi

echo "✅ Java verified successfully"
