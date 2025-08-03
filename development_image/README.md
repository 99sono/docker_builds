# Development Docker Environment

A comprehensive, multi-layered Docker development environment supporting Java, Node.js, and Python development with SSH access and IDE integration.

## 🚀 Quick Start

### Prerequisites
- Docker installed
- SSH key pair (for passwordless login)

### 1. Build the Environment
```bash
# Build all layers
./scripts/build_all.sh

# Or build individually
cd 01_build_base_software_image && ./build.sh
cd 02_build_dev_environments_image && ./build.sh
cd 04_project_stubs && ./build.sh
```

### 2. Start Development Environment
```bash
# Using Docker Compose (recommended)
docker-compose up -d

# Or using individual container
./scripts/01_run_final_container.sh
```

### 3. Connect via SSH
```bash
# Upload your SSH key first
./scripts/04_upload_public_key_to_container.sh

# Connect
ssh developer@localhost -p 2222
```

## 📁 Project Structure

```
development_image/
├── 00_common_env.sh              # Environment configuration
├── 01_build_base_software_image/ # Base Ubuntu + SSH setup
├── 02_build_dev_environments_image/    # Java, Node.js, Python
├── 03_project_stubs/            # Project templates
├── docs/                        # Documentation
├── scripts/                     # Helper scripts
├── docker-compose.yml           # Daily development setup
└── README.md
```

## 🛠️ Pre-installed Tools

### Languages & Runtimes
- **Java**: OpenJDK 21 + Maven 3.9.6
- **Node.js**: 20.11.1 LTS + npm
- **Python**: Miniforge3 (conda) with Python 3.11

### Development Tools
- **SSH**: Key-based authentication only
- **Git**: Latest version with LFS
- **Editors**: vim, nano
- **Build Tools**: make, gcc, build-essential

## 🔧 Daily Usage

### Starting Development
```bash
# Start environment
docker-compose up -d

# (a) SSH into container 
ssh developer@localhost -p 2222

# (b) Docker interactive shell 
docker exec -it -u developer "${CONTAINER_NAME}" /bin/bash


# Navigate to workspace
cd /home/developer/dev
```

### Project Setup Examples
- [Java Spring Boot](docs/usage_examples/java_project_setup.md)
- [Node.js Express/React](docs/usage_examples/nodejs_project_setup.md)

### Volume Mounting
```bash
# Mount local project
docker run -d \
  --name dev-container \
  -p 2222:22 \
  -p 3000-3005:3000-3005 \
  -p 8080-8085:8080-8085 \
  -v $(pwd)/your-project:/home/developer/dev/your-project \
  development-image:latest
```

## 🌐 Port Mapping

| Service | Port | Description |
|---------|------|-------------|
| SSH | 2222 | SSH access for IDEs |
| Node.js | 3000-3005 | Development servers |
| Java | 8080-8085 | Spring Boot apps |
| Debug | 5005 | Java remote debugging |

## 🔍 Verification

Each build stage includes comprehensive verification:
```bash
# Verify base image
cd 01_build_base_software_image/verify && ./05_verify_ssh_login_possible.sh

# Verify dev environment
cd 02_build_dev_environments_image/verify && ./03_verify_java_install.sh

# Check all installations
./scripts/03_verify_installations.sh
```

## 🆘 Troubleshooting

1. **Check container logs**: `docker logs daily-dev-container`
2. **Verify SSH connection**: `ssh developer@localhost -p 2222`
3. **Check tool installations**: `./scripts/03_verify_installations.sh`

## 🏗️ Architecture

The environment uses a layered approach:

1. **Base Layer**: Ubuntu 24.04 LTS + SSH + essential tools
2. **Dev Layer**: Java, Node.js, Python with package managers
3. **Coding Agents**: Not  implemented yet
4. **Project Layer**: Templates and scaffolding tools

## 🎯 Use Cases

- **Full-Stack Development**: Java backend + React frontend
- **Machine Learning**: Python with conda environments
- **Microservices**: Multiple Node.js services
- **Team Development**: Consistent environments across team
