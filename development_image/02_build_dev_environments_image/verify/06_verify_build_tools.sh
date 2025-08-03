#!/bin/bash
source ../../00_common_env.sh

echo "=== Verifying Essential Build Tools ==="

TOOLS=("gcc" "g++" "make" "pkg-config" "mvn")
MISSING_TOOLS=0

for tool in "${TOOLS[@]}"; do
    if ! docker exec ${TEST_CONTAINER_NAME} which ${tool} >/dev/null 2>&1; then
        echo "❌ Missing $tool"
        MISSING_TOOLS=1
    else
        echo "✅ Found $tool"
    fi
done

if [ $MISSING_TOOLS -ne 0 ]; then
    echo "❌ Some build tools are missing"
    exit 1
fi

echo "✅ All build tools verified successfully"
