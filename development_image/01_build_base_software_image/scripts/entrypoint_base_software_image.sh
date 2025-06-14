#!/bin/bash

# Generate SSH host keys if they don't already exist.
# The sshd-keygen script is idempotent: it checks for existing keys (e.g., /etc/ssh/ssh_host_*_key)
# and only generates missing keys. This ensures keys are not regenerated unnecessarily on container restarts,
# preventing issues with SSH clients expecting consistent host keys.
# Note: For consistent keys across container restarts, /etc/ssh/ must be persisted (e.g., via a Docker volume).
#  (e.g., -v ssh_keys:/etc/ssh).
# The '|| true' ensures the script continues even if sshd-keygen fails (e.g., due to permissions or missing directories).
sudo /usr/sbin/sshd-keygen || true

# Start the SSH daemon in the background.
# This runs sshd as a service, allowing remote SSH connections to the container.
sudo /usr/sbin/sshd

# Run a custom SSH setup script if it exists.
# This allows additional SSH configuration (e.g., setting up user keys) as the 'developer' user.
# The script is optional and only executed if present.
if [ -f /usr/local/bin/setup_ssh.sh ]; then
    /usr/local/bin/setup_ssh.sh
fi

# Keep the container running indefinitely.
# Using 'tail -f /dev/null' as a lightweight way to prevent the container from exiting,
# while running as the 'developer' user.
exec tail -f /dev/null