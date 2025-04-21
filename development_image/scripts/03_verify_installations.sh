#!/bin/bash

echo "=== Verifying Miniforge3 Installation ==="
docker exec test-dev-container bash -c 'source ~/.bashrc && conda info'

echo -e "\n=== Verifying Node.js Installation ==="
docker exec test-dev-container bash -c 'source ~/.bashrc && node --version && npm --version'

echo -e "\n=== Verifying Java Installation ==="
docker exec test-dev-container bash -c 'java -version && mvn -version'

echo -e "\n=== Verifying Programs Directory Structure ==="
docker exec test-dev-container ls -la /home/developer/programs