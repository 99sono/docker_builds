#!/bin/bash
source ../../00_common_env.sh

echo "=== Verifying Java Installation ==="

# 1. Verify Java binary
if ! docker exec ${TEST_CONTAINER_NAME} java -version 2>&1 | grep -q "openjdk version \"25"; then
    echo "❌ Wrong Java version installed"
    exit 1
fi

# 2. Verify /usr/bin/java symlink
EXPECTED_BIN_LINK="/etc/alternatives/java"
ACTUAL_BIN_LINK=$(docker exec ${TEST_CONTAINER_NAME} readlink /usr/bin/java)
if [ "$ACTUAL_BIN_LINK" != "$EXPECTED_BIN_LINK" ]; then
    echo "❌ /usr/bin/java does not point to $EXPECTED_BIN_LINK (is: $ACTUAL_BIN_LINK)"
    exit 1
fi

# 3. Verify /etc/alternatives/java symlink
EXPECTED_ALT_LINK="/usr/lib/jvm/java-25-openjdk-amd64/bin/java"
ACTUAL_ALT_LINK=$(docker exec ${TEST_CONTAINER_NAME} readlink /etc/alternatives/java)
if [ "$ACTUAL_ALT_LINK" != "$EXPECTED_ALT_LINK" ]; then
    echo "❌ /etc/alternatives/java does not point to $EXPECTED_ALT_LINK (is: $ACTUAL_ALT_LINK)"
    exit 1
fi

echo "✅ Java verified successfully"
