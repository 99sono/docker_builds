#!/bin/bash
source ../../00_common_env.sh

echo "=== Verifying Essential Build Tools ==="

TOOLS=("mvn" "pkg-config" "build-essential")
MISSING_TOOLS=0

for tool in "${TOOLS[@]}"; do
    if ! docker exec ${TEST_CONTAINER_NAME} which ${tool} >/dev/null 2>&1; then
        echo "❌ Missing $tool"
        MISSING_TOOLS=1
    fi
done

if [ $MISSING_TOOLS -ne 0 ]; then
    exit 1
fi

echo "✅ All build tools verified successfully"
