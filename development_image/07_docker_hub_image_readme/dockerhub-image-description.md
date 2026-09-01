# 99sono/99sono-public-repo

Development Environment Docker Image

## Overview

A multi-layered development environment container featuring Java, Node.js, and Python development tools, along with 5 AI coding agents for modern software development. Built using a 4-layer architecture with comprehensive verification testing. Designed for use with VS Code's "Attach to Running Container" feature.

## What's Included

*Software versions verified: 09/01/2026*

### Programming Languages & Runtimes
- **OpenJDK 21** with Maven 3.9.6
- **Node.js v24.19.0** (via Miniforge3 conda base environment)
- **Python 3.14.7** with Miniforge3 (conda environments allow installing any Python version needed)
- Build tools (gcc, make, cmake)

### Development Tools
- **Git & Git LFS** - Version control
- **SSH Server** - Remote access capability
- **Text Editors** - Vim, Nano (plus tmux for terminal multiplexing)
- **Build Tools** - Make, cmake, etc.

### AI Coding Agents
- **RTK** (Rust Token Kit) - Shared token management prerequisite
- **Cline** - Advanced coding assistant (npm)
- **OpenCode** - Coding assistant (npm)
- **Antigravity** - Google's AI coding agent (native binary)
- **OpenAI Codex** - OpenAI's coding CLI (npm)

### System Utilities
- **Network Tools** - curl, wget, net-tools, tcpdump, iputils-ping
- **Process Monitoring** - htop, procps, psmisc
- **File Management** - zip, unzip
- **System Admin** - sudo, logrotate, cron

## Prerequisites

- Docker
- VS Code with "Dev Containers" extension (recommended)
- Sufficient disk space (~5GB for full image)

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

```yaml
version: "3.9"

services:
  dev:
    image: 99sono/99sono-public-repo:dev-environment-1.0.0-SNAPSHOT
    container_name: dev-environment
    ports:
      - "2222:22"
    volumes:
      - ~/dev:/home/developer/dev
      - ~/.gitconfig:/home/developer/.gitconfig
      - ~/.ssh:/home/developer/.ssh
    environment:
      OPENAI_API_KEY: ${OPENAI_API_KEY:-}
```

## Environment Variables

### AI Coding Agent Configuration
- `OPENAI_API_KEY` - Optional, for OpenAI Codex (alternative to `codex login`)

> **Note:** Cline, OpenCode, and Antigravity manage their own authentication via interactive login flows. No environment variables are needed for basic operation of these agents.

### System Configuration
- Timezone: Europe/Zurich (configurable at build time)
- User: developer (password: developer)
- Working directory: /home/developer/dev

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
- **Cline**: Multi-provider AI coding assistant
- **OpenCode**: Terminal-based AI coding agent
- **Antigravity**: Google's agentic coding platform
- **OpenAI Codex**: OpenAI's CLI coding agent

### Container-Based Development
- Isolated, reproducible environments
- Easy cleanup and reset
- Consistent tooling across machines

## Build Source

The build files, Dockerfiles, and scripts used to create this image are available at:
**https://github.com/99sono/docker_builds**

This repository contains the complete build pipeline with 4 layers of Docker images:
- **Layer 01**: Base Ubuntu 24.04 LTS with SSH and essential tools
- **Layer 02**: Development environments (Miniforge3 with Node.js & Python, Java 21, build tools)
- **Layer 03**: AI coding agents (RTK, Cline, OpenCode, Antigravity, Codex)
- **Layer 04**: Project stubs and final container assembly

## Tags

- `dev-environment-1.0.0-SNAPSHOT` - Latest development snapshot
- Versioned tags planned for stable releases

## License

MIT License — see the [LICENSE](LICENSE) file in the source repository for full terms.
