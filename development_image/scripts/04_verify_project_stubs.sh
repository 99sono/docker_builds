#!/bin/bash

echo "=== Java Project Stubs ==="
docker exec test-dev-container bash -c 'ls -R /home/developer/dev/java'
echo -e "\n=== Sample Java Project Content ==="
docker exec test-dev-container bash -c 'cat /home/developer/dev/java/dummy_java_project01/pom.xml'

echo -e "\n=== Node.js Project Stubs ==="
docker exec test-dev-container bash -c 'ls -R /home/developer/dev/node'
echo -e "\n=== Sample Node.js Project Content ==="
docker exec test-dev-container bash -c 'cat /home/developer/dev/node/dummy_node_project01/package.json'

echo -e "\n=== Python Project Stubs ==="
docker exec test-dev-container bash -c 'ls -R /home/developer/dev/python'
echo -e "\n=== Sample Python Project Content ==="
docker exec test-dev-container bash -c 'cat /home/developer/dev/python/dummy_python_project01/main.py'