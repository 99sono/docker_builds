#!/bin/bash

# Source common environment variables
source ../../00_common_env.sh

# Objective:
# Verify that when logging in with 'docker exec -it <container> /bin/bash',
# the current working directory is the developer user's home directory.

EXPECTED_HOME="/home/developer"

CURRENT_PATH=$(docker exec ${TEST_CONTAINER_NAME} bash -c 'pwd')

if [ "$CURRENT_PATH" = "$EXPECTED_HOME" ]; then
    echo "✅ OK: Current path is the developer's home directory ($EXPECTED_HOME)."
else
    echo "❌ ERROR: Current path is $CURRENT_PATH, expected $EXPECTED_HOME!"
    exit 1
fi
