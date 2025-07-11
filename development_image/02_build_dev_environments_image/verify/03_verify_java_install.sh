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
# (base) developer@8ebaa270baa0:~()$ java --version
# openjdk 17.0.15 2025-04-15
# OpenJDK Runtime Environment (build 17.0.15+6-Ubuntu-0ubuntu125.04)
# OpenJDK 64-Bit Server VM (build 17.0.15+6-Ubuntu-0ubuntu125.04, mixed mode, sharing)
if ! docker exec ${TEST_CONTAINER_NAME} java -version 2>&1 | grep -i "openjdk version \"17"; then
    echo "❌ Wrong Java version installed"
    exit 1
fi

echo "✅ Java verified successfully"
