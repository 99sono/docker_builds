#!/bin/bash
# Script to set up SSH keys for the developer user

# Ensure .ssh directory exists with correct permissions
mkdir -p /home/developer/.ssh
chmod 700 /home/developer/.ssh
chown developer:developer /home/developer/.ssh

# Placeholder for public key
if [ -f /home/developer/.ssh/authorized_keys ]; then
    chmod 600 /home/developer/.ssh/authorized_keys
    chown developer:developer /home/developer/.ssh/authorized_keys
else
    echo "Warning: No authorized_keys file found. Please add public key to /home/developer/.ssh/authorized_keys"
fi

# Ensure SSH service is running
service ssh start