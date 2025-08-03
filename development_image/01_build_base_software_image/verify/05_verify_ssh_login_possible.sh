#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  

# Remove host id from known hosts (each time we generate the container the server key will change)
ssh-keygen -f ~/.ssh/known_hosts -R '[localhost]:2222'

# Pre-condition:
# make sure the script that uploads your public key as authorized key has been uploaded first.
ssh ssh://developer@localhost:2222

