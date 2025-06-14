#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  

# Objective:  
# The `developer` user is expected to have a user ID of 1000,  
# matching the typical UID of a WSL2 Ubuntu user.  
# This alignment simplifies directory mounting.  

# Connect to the running `test-dev-container` and verify the UID  
echo -e "\n=== Verifying that the 'developer' user has UID 1000 ==="  

UID_VALUE=$(docker exec ${TEST_CONTAINER_NAME} bash -c 'id -u developer')

# Check if UID matches expected value  
if [ "$UID_VALUE" -eq 1000 ]; then  
    echo "✅ OK: Developer user has the expected UID 1000."  
else  
    echo "❌ ERROR: Unexpected UID detected ($UID_VALUE). Developer user should have UID 1000!"  
    exit 1  
fi