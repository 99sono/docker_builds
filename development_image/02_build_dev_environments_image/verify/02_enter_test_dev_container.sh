#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  

# Enter the test dev container
docker exec -it "${TEST_CONTAINER_NAME}" /bin/bash