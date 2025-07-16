#!/bin/bash

# Source common environment variables
source ../../00_common_env.sh

# Objective:
# Verify that /etc/ssh/sshd_config contains the expected configuration lines.

EXPECTED_CONFIG="PasswordAuthentication no
PermitRootLogin no
AllowUsers developer
X11Forwarding no
MaxAuthTries 3
PubkeyAuthentication yes"

ACTUAL_CONFIG=$(docker exec ${TEST_CONTAINER_NAME} bash -c "grep -E 'PasswordAuthentication|PermitRootLogin|AllowUsers|X11Forwarding|MaxAuthTries|PubkeyAuthentication' /etc/ssh/sshd_config")

if [ "$ACTUAL_CONFIG" = "$EXPECTED_CONFIG" ]; then
    echo "✅ OK: /etc/ssh/sshd_config matches expected configuration."
else
    echo "❌ ERROR: /etc/ssh/sshd_config does not match expected configuration!"
    echo "--- Actual config ---"
    echo "$ACTUAL_CONFIG"
    echo "--- Expected config ---"
    echo "$EXPECTED_CONFIG"
    exit 1
fi
