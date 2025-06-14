#!/bin/bash

# Source common environment variables  
source ../../00_common_env.sh  



# Script to upload a local public SSH key to a Docker container's authorized_keys file
# for passwordless SSH access as the 'developer' user.

# Configuration variables
CONTAINER_NAME="${TEST_CONTAINER_NAME}"  # Replace with your container name or ID
PUBLIC_KEY_PATH="$HOME/.ssh/id_ed25519.pub"  # Path to your public key
DEVELOPER_USER="developer"  # Container user for SSH access
AUTHORIZED_KEYS_PATH="/home/$DEVELOPER_USER/.ssh/authorized_keys"  # Path inside container

# Check if the public key file exists
if [ ! -f "$PUBLIC_KEY_PATH" ]; then
  echo "Error: Public key not found at $PUBLIC_KEY_PATH"
  exit 1
fi

# Check if the container is running
if ! docker ps --filter "name=$CONTAINER_NAME" --format '{{.Names}}' | grep -q "$CONTAINER_NAME"; then
  echo "Error: Container '$CONTAINER_NAME' is not running"
  exit 1
fi

# Create .ssh directory in the container if it doesn't exist
docker exec "$CONTAINER_NAME" bash -c "mkdir -p /home/$DEVELOPER_USER/.ssh && chown $DEVELOPER_USER:$DEVELOPER_USER /home/$DEVELOPER_USER/.ssh && chmod 700 /home/$DEVELOPER_USER/.ssh"

# Copy the public key to a temporary location in the container
docker cp "$PUBLIC_KEY_PATH" "$CONTAINER_NAME:/tmp/id_ed25519.pub"

# Append the public key to authorized_keys, ensuring proper permissions
docker exec "$CONTAINER_NAME" bash -c "cat /tmp/id_ed25519.pub >> $AUTHORIZED_KEYS_PATH && rm /tmp/id_ed25519.pub && chown $DEVELOPER_USER:$DEVELOPER_USER $AUTHORIZED_KEYS_PATH && chmod 600 $AUTHORIZED_KEYS_PATH"

# Verify the key was added
docker exec "$CONTAINER_NAME" bash -c "grep -q '$(cat "$PUBLIC_KEY_PATH")' $AUTHORIZED_KEYS_PATH && echo 'Public key successfully added to $AUTHORIZED_KEYS_PATH' || echo 'Error: Failed to add public key'"

# Optional: Restart sshd to ensure changes take effect (uncomment if needed)
# docker exec "$CONTAINER_NAME" bash -c "pkill -HUP sshd"

echo "Setup complete. You should now be able to SSH into the container as '$DEVELOPER_USER' without a password using your SSH key."
