# Base Software Image (Level 01)

This layer provides the foundation for development environments with system utilities and security configurations.

## Contents

### System Tools
- Version Control: git, git-lfs
- Network Tools: net-tools, curl, wget, tcpdump
- System Monitoring: htop, top, psmisc
- Text Editors: vim, nano
- Terminal Multiplexer: tmux
- Compression: zip, unzip
- System Services: logrotate, cron
- SSH Server with secure configuration

### Development Setup
- Non-root user 'developer' with sudo access
- Structured workspace in /home/developer/dev
- Git-aware command prompt
- Timezone configuration (default: Europe/Zurich)

## Building

```bash
# From this directory
./build.sh
```

## Usage

1. Start a container:
```bash
docker run -d \
  -p 2222:22 \
  --name base-dev \
  development-level01-basic-software:1.0.0
```

2. Configure SSH access:
```bash
# Copy your SSH public key
docker cp ~/.ssh/id_rsa.pub base-dev:/home/developer/.ssh/authorized_keys

# Fix permissions inside container
docker exec base-dev chown developer:developer /home/developer/.ssh/authorized_keys
docker exec base-dev chmod 600 /home/developer/.ssh/authorized_keys
```

3. Connect:
```bash
ssh -p 2222 developer@localhost
```

## Customization

### SSH Configuration
- Edit `config/sshd_config` before building
- Key-based authentication only
- Root login disabled

### Workspace Structure
The `/home/developer/dev` directory contains:
- java/
- python/
- node/

Each directory is prepared for its respective development environment.