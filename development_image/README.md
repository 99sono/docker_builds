# Development Docker Environment

A multi-layered Docker development environment with SSH access, full language toolchains, and AI coding agents.

## 🏗️ Architecture

The environment is built as a 4-layer Docker image stack:

| Layer | Directory | Image | Purpose |
|-------|-----------|-------|---------|
| 01 | `01_build_base_software_image/` | `development-level01-base-software:1.0.0` | Ubuntu 24.04, sshd, essential tools |
| 02 | `02_build_dev_environments_image/` | `development-level02-dev-environments:1.0.0` | Miniforge3 (Node.js, Python), Java 21, build tools |
| 03 | `03_adding_coding_agents_to_docker_image/` | `development-level03-coding-agents:1.0.0` | RTK, Cline, OpenCode, Antigravity, Codex |
| 04 | `04_project_stubs/` | `development-level04-project-stubs:1.0.0` | Final image with sample project stubs |

A Docker Compose template in `05_docker_compose_template/` shows how to run the final image.

## 🚀 Quick Start

### Prerequisites
- Docker installed
- SSH key pair (for passwordless login to the container)

### 1. Build the Environment
```bash
# Build all layers in order
./scripts/build_all.sh

# Or build individually
cd 01_build_base_software_image && ./build.sh
cd ../02_build_dev_environments_image && ./build.sh
cd ../03_adding_coding_agents_to_docker_image && ./build.sh
cd ../04_project_stubs && ./build.sh
```

### 2. Start the Container
```bash
# Using the compose template
cd 05_docker_compose_template
docker compose up -d

# Or directly
docker run -d \
  --name dev-environment \
  -p 2222:22 \
  development-level04-project-stubs:1.0.0
```

### 3. Connect via SSH
```bash
# Upload your SSH public key and fix permissions
docker cp ~/.ssh/id_rsa.pub dev-environment:/home/developer/.ssh/id_rsa.pub
docker exec -u root dev-environment sh -c \
  "chown developer:developer /home/developer/.ssh/id_rsa.pub && chmod 600 /home/developer/.ssh/id_rsa.pub"

# Connect
ssh developer@localhost -p 2222
```

## 📁 Project Structure

```
development_image/
├── 00_common_env.sh                     # Shared environment config
├── 01_build_base_software_image/        # Layer 01: Base OS + SSH
├── 02_build_dev_environments_image/     # Layer 02: Dev environments
├── 03_adding_coding_agents_to_docker_image/  # Layer 03: AI coding agents
├── 04_project_stubs/                    # Layer 04: Final image + stubs
├── 05_docker_compose_template/          # Compose template for running
├── docs/                                # Usage examples & documentation
├── scripts/                             # Build & helper scripts
└── README.md
```

## 🛠️ Pre-installed Tools

### Languages & Runtimes
- **Java**: OpenJDK 21 + Maven 3.9.6
- **Node.js**: v24.19.0 (via Miniforge3 conda base environment)
- **Python**: 3.14.7 (via Miniforge3 conda base environment)

### AI Coding Agents
- **RTK** (Rust Token Kit) — shared token management prerequisite
- **Cline** — npm-based coding agent
- **OpenCode** — npm-based coding agent
- **Antigravity** — native binary (Google agent)
- **OpenAI Codex** — npm-based CLI (auth via `codex login` or `OPENAI_API_KEY`)

### Development Tools
- **SSH**: Key-based authentication only
- **Git**: Latest version with LFS
- **Editors**: vim, nano
- **Build Tools**: make, gcc, build-essential

## 🔧 Daily Usage

### Starting Development
```bash
# Start environment (from 05_docker_compose_template/)
docker compose up -d

# SSH into container
ssh developer@localhost -p 2222

# Or interactive shell
docker exec -it -u developer dev-environment /bin/bash

# Navigate to workspace
cd /home/developer/dev
```

### Project Setup Examples
- [Java Spring Boot](docs/usage_examples/java_project_setup.md)
- [Node.js Express/React](docs/usage_examples/nodejs_project_setup.md)

### Volume Mounting
```bash
docker run -d \
  --name dev-container \
  -p 2222:22 \
  -v $(pwd)/your-project:/home/developer/dev/your-project \
  development-level04-project-stubs:1.0.0
```

## 🌐 Port Mapping

| Host | Container | Description |
|------|-----------|-------------|
| 2222 | 22 | SSH access |

> Add additional port mappings as needed for your project's dev servers.

## 🔍 Verification

Each layer includes a verification suite. Run all verifications for a layer:
```bash
# Layer 01
cd 01_build_base_software_image/verify && ./00_run_all_verifications.sh

# Layer 02
cd 02_build_dev_environments_image/verify && ./00_run_all_verifications.sh

# Layer 03
cd 03_adding_coding_agents_to_docker_image/verify && ./00_run_all_verifications.sh

# Layer 04
cd 04_project_stubs/verify && ./00_run_all_verifications.sh
```

## 🆘 Troubleshooting

1. **Check container logs**: `docker logs dev-environment`
2. **Verify SSH connection**: `ssh developer@localhost -p 2222`
3. **Check tool installations**: `docker exec -it dev-environment bash -lc "node --version && python --version && java -version"`

## 🎯 Use Cases

- **AI-Assisted Development**: Full agent toolkit (Cline, OpenCode, Antigravity, Codex) with RTK
- **Full-Stack Development**: Java backend + Node.js frontend + Python scripting
- **Machine Learning**: Python with conda environments
- **Team Development**: Consistent environments across team
