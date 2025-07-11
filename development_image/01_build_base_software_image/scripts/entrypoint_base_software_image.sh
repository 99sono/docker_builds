#!/bin/bash

# Generate SSH host keys if they don't already exist.
# The sshd-keygen script is idempotent: it checks for existing keys (e.g., /etc/ssh/ssh_host_*_key)
# and only generates missing keys. This ensures keys are not regenerated unnecessarily on container restarts,
# preventing issues with SSH clients expecting consistent host keys.
# Note: For consistent keys across container restarts, /etc/ssh/ must be persisted (e.g., via a Docker volume).
#  (e.g., -v ssh_keys:/etc/ssh).
# The '|| true' ensures the script continues even if sshd-keygen fails (e.g., due to permissions or missing directories).

# Generate SSH host keys if missing
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    echo Generate SSH host keys as they are missing.
    sudo /usr/bin/ssh-keygen -A
fi


# Start the SSH daemon in the background.
# This runs sshd as a service, allowing remote SSH connections to the container.
# NOTE: Start the SSH daemon as root using 'sudo su -c', as a workaround for
# "start-stop-daemon: unable to set gid to 0 (Operation not permitted)".
# Even though 'developer' is a passwordless sudoer (UID/GID 1000), starting sshd
# directly with sudo can still fail in Docker due to capability restrictions.
# This approach ensures sshd runs as root, while keeping the default user as 'developer'.
echo Start the ssh service.
sudo su -c "/usr/sbin/sshd"


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