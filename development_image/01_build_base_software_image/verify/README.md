# Verify

## Overview  
This folder contains scripts designed to verify that the produced Docker image behaves as expected. These verification steps ensure consistency in user configurations, permissions, and runtime behavior.

## Included Scripts  
- **`02_verify_developer_user_id.sh`** – Confirms that the `developer` user in the container has the expected user ID (`UID 1000`).  

## Usage  
Run the verification script inside a running container:  

```bash
./02_verify_developer_user_id.sh
```

Make sure the container is running before executing the script.

## Purpose  
These checks help validate the correctness of the container setup, ensuring compatibility with WSL2 and other development environments. If any mismatches are found, adjustments to the Dockerfile may be necessary.