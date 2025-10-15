# 99sono/99sono-public-repo

Development Environment Docker Image

## Overview

A comprehensive development environment container featuring Java, Node.js, and Python development tools, along with CLI tools for modern software development. Designed for use with VS Code's "Attach to Running Container" feature.

## What's Included

*Software versions last verified: 2025.10.15 at 21:31 UTC+2*

### Programming Languages & Runtimes
- **OpenJDK 21.0.8** with Maven 3.9.6
- **Node.js v24.9.0**
- **Python 3.12.11** with Miniconda3/Miniforge (conda environments allow installing any Python version needed)
- **OpenJDK** and build tools

### Development Tools
- **Git & Git LFS** - Version control
- **SSH Server** - Remote access capability
- **Text Editors** - Vim, Nano (plus tmux for terminal multiplexing)
- **Build Tools** - Make, cmake, etc.

### Coding Agents & AI Tools (versions current as of 2025.10.15)
- **Grok CLI (1.0.1)** - xAI's coding assistant
- **Gemini CLI (0.9.0)** - Google's AI coding assistant
- **Qwen Code (0.0.14)** - OpenAI-compatible CLI coding assistant
- **Claude Code** - Anthropic's coding assistant
- **OpenAI Codex (0.46.0)** - Direct OpenAI integration

### System Utilities
- **Network Tools** - curl, wget, net-tools, tcpdump, iputils-ping
- **Process Monitoring** - htop, procps, psmisc
- **File Management** - zip, unzip
- **System Admin** - sudo, logrotate, cron

## Prerequisites

- Docker
- VS Code with "Dev Containers" extension (recommended)
- Sufficient disk space (~4.9GB for full image)

## Quick Start with VS Code

1. **Pull the image:**
   ```bash
   docker pull 99sono/99sono-public-repo:dev-environment-1.0.0-SNAPSHOT
   ```

2. **Run the container:**
   ```bash
   docker run -d \
     --name dev-env \
     -p 2222:22 \
     -v ~/dev:/home/developer/dev \
     99sono/99sono-public-repo:dev-environment-1.0.0-SNAPSHOT
   ```

3. **Attach with VS Code:**
   - Ctrl+Shift+P → "Dev Containers: Attach to Running Container"
   - Select the running container
   - Start developing!

## Docker Compose Example

For a more comprehensive setup, see the [usage examples repository](https://github.com/99sono/DockerBuildFiles/tree/master/dev-image):

```yaml
version: "3.9"

services:
  dev:
    image: 99sono/99sono-public-repo:dev-environment-1.0.0-SNAPSHOT
    container_name: dev-environment
    ports:
      - "2222:22"
    volumes:
      - ~/dev:/home/developer/dev/mount
      - ~/.gitconfig:/home/developer/.gitconfig
      - ~/.ssh:/home/developer/.ssh
      - ~/.m2:/home/developer/.m2
      - ~/docker/DockerBuildFiles/dev-image/.vscode-server:/home/developer/.vscode-server
    environment:
      OPENAI_API_KEY: ${OPENAI_API_KEY:-}
      GEMINI_API_KEY: ${GEMINI_API_KEY:-}
    networks:
      - development-network

networks:
  development-network:
    external: true
```

## Environment Variables

### AI/Coding Assistant Configuration
- `OPENAI_API_KEY` - For Qwen Code and OpenAI integration
- `OPENAI_BASE_URL` - Custom OpenAI-compatible API endpoint
- `OPENAI_MODEL` - Model selection
- `GEMINI_API_KEY` - For Gemini CLI
- `OPENROUTER_API_KEY` - For OpenRouter integration

### System Configuration
- Timezone: Europe/Zurich (configurable at build time)
- User: developer (password: developer)
- Working directory: /home/developer

## SSH Access

The container runs an SSH server on port 22 (map to host port 2222). SSH keys can be mounted or uploaded.

```bash
# Connect via SSH
ssh developer@localhost -p 2222
```

## Supported Workflows

### Multi-Language Development
- **Java**: Maven projects, Spring Boot, enterprise applications
- **JavaScript/TypeScript**: Node.js apps, React/Vue/Angular
- **Python**: ML/AI projects with conda environments

### AI-Assisted Coding
- Natural language to code conversion
- Code explanation and documentation
- Refactoring suggestions
- Bug identification

### Container-Based Development
- Isolated, reproducible environments
- Easy cleanup and reset
- Consistent tooling across machines

## Build Source

The build files, Dockerfiles, and scripts used to create this image are available at:
**https://github.com/99sono/docker_builds**

This repository contains the complete build pipeline with 5 layers of Docker images.

## Tags

- `dev-environment-1.0.0-SNAPSHOT` - Latest development snapshot
- Versioned tags planned for stable releases

## License

See the source repository for licensing information.

## Acknowledgments

- Built using xAI's Grok LLM for architecture and documentation
- Inspired by modern development workflow best practices
