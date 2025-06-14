# Verify

## Overview
This folder contains scripts to verify that the built Docker image for the base software environment is correctly configured and behaves as expected. These scripts help validate container startup, entrypoint behavior, SSH access, user configuration, and log output, ensuring the image is suitable for development workflows.

## Included Scripts
- **01_A_run_built_container_entrypoint_script.sh** – Starts the test container with the default entrypoint to verify normal startup.
- **01_B_run_built_container_override_entrypoint.sh** – Starts the test container with the entrypoint overridden (runs `sleep infinity`) for debugging entrypoint issues.
- **02_enter_test_dev_container.sh** – Opens an interactive shell inside the running test container.
- **03_check_logs.sh** – Displays logs from the running test container for troubleshooting.
- **04_upload_public_key_to_container.sh** – Uploads your local SSH public key to the container's `authorized_keys` for passwordless SSH as the `developer` user.
- **05_verify_ssh_login_possible.sh** – Attempts SSH login to the container as the `developer` user to confirm SSH setup.
- **06_verify_developer_user_id.sh** – Verifies that the `developer` user inside the container has UID 1000, ensuring compatibility with typical development environments (e.g., WSL2).

## Usage
1. Ensure the Docker image is built and available locally.
2. Run the scripts as needed, typically in the following order:
   - Start the container: `./01_A_run_built_container_entrypoint_script.sh` (or use `01_B_...` for debugging)
   - Enter the container: `./02_enter_test_dev_container.sh`
   - Check logs: `./03_check_logs.sh`
   - Upload your SSH public key: `./04_upload_public_key_to_container.sh` (ensure you have a public key at `~/.ssh/id_ed25519.pub`)
   - Verify SSH login: `./05_verify_ssh_login_possible.sh`
   - Verify developer UID: `./06_verify_developer_user_id.sh`

> **Note:** Some scripts require the container to be running. SSH-related scripts require a valid public key.

## Purpose
These checks help validate the correctness and usability of the container setup, ensuring a consistent and functional development environment. If any mismatches or issues are found, adjustments to the Dockerfile or setup scripts may be necessary.

## Troubleshooting
- If a script fails, check that the container is running and the required environment variables are set.
- Ensure your SSH public key exists at the specified path before running SSH-related scripts.
- Review container logs (`03_check_logs.sh`) for additional details if something does not work as expected.