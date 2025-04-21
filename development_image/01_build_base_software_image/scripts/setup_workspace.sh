#!/bin/bash
# Script to set up the development workspace structure

# Create development workspace directories
mkdir -p /home/developer/dev/{python,node,java}

# Set correct ownership
chown -R developer:developer /home/developer/dev

# Create workspace README
cat > /home/developer/dev/README.md << EOL
# Development Workspace

This is your development workspace with separate directories for different development environments:

- \`python/\` - Python development environment with virtual environment
- \`node/\` - Node.js development environment
- \`java/\` - Java development environment

Each environment comes with its own setup and configuration.
EOL

# Set ownership for README
chown developer:developer /home/developer/dev/README.md