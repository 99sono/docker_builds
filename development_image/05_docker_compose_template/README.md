# Docker Compose Development Environment

This directory contains a complete Docker Compose setup for daily development using the development environment image.

## 🚀 Quick Start

### 1. Initial Setup
```bash
# Copy environment template
cp .env.example .env

# Edit .env to customize ports and paths
nano .env

# Pull required images
./01_pull_images.sh
```

### 2. Start Development Environment
```bash
# Start all services
./02_start_dev.sh
```

### 3. Access the Environment
```bash
# Enter container interactively
./03_enter_container.sh

# Or connect via SSH
ssh developer@localhost -p 2222
```

## 📁 Directory Structure
```
05_docker_compose_template/
├── .env.example          # Environment variables template
├── docker-compose.yml    # Main compose configuration
├── 01_pull_images.sh     # Pull required images
├── 02_start_dev.sh       # Start development environment
├── 03_enter_container.sh # Enter container interactively
└── README.md            # This file
```

## 🔧 Configuration

### Environment Variables (.env)
- **DEV_IMAGE_NAME**: Development image name
- **DEV_IMAGE_VERSION**: Image version tag
- **CONTAINER_NAME**: Container name
- **SSH_HOST_PORT**: SSH port on host (default: 2222)
- **DEV_VOLUME_PATH**: Local path for development files
- **SSH_KEYS_PATH**: Local path for SSH keys

### Port Mapping
| Service | Host Port | Container Port | Description |
|---------|-----------|----------------|-------------|
| SSH | 2222 | 22 | SSH access |
| Node.js 1 | 3000 | 3000 | Node.js app |
| Node.js 2 | 3001 | 3001 | Node.js app |
| Java | 8080 | 8080 | Java app |
| Java Debug | 5005 | 5005 | Java remote debug |
| PostgreSQL | 5432 | 5432 | Database |
| Redis | 6379 | 6379 | Cache |

## 📁 Volume Mounting

### Development Files
- **Local**: `./dev/`
- **Container**: `/home/developer/dev/`
- **Purpose**: Your projects and code

### SSH Keys
- **Local**: `./ssh-keys/`
- **Container**: `/home/developer/.ssh/keys/`
- **Purpose**: SSH key-based authentication

## 🎯 Daily Usage

### Starting Work
```bash
cd 05_docker_compose_template
./02_start_dev.sh
```

### Working with Projects
```bash
# Enter container
./03_enter_container.sh

# Inside container
cd /home/developer/dev
ls -la  # See your projects
```

### Stopping Environment
```bash
docker-compose down
```

### Viewing Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f dev-environment
```

## 🔍 Troubleshooting

### Container Not Starting
```bash
# Check logs
docker-compose logs dev-environment

# Check if ports are available
netstat -tulpn | grep :2222
```

### SSH Connection Issues
```bash
# Check SSH key permissions
ls -la ssh-keys/

# Test SSH connection
ssh -v developer@localhost -p 2222
```

### Volume Mount Problems
```bash
# Check volume mounts
docker inspect daily-dev-container | grep Mounts -A 20

# Verify directory permissions
ls -la dev/
```

## 🛠️ Customization

### Adding New Services
Edit `docker-compose.yml` to add new services:

```yaml
  new-service:
    image: new-service:latest
    ports:
      - "8081:8080"
    networks:
      - dev-network
```

### Changing Ports
Edit `.env` file:
```bash
SSH_HOST_PORT=2223
NODE_PORT_1=3002
```

### Adding Environment Variables
Add to `.env`:
```bash
MY_CUSTOM_VAR=value
```

## 🌐 IDE Integration

### IntelliJ IDEA
1. Install "Remote Development" plugin
2. Connect via SSH: `localhost:2222`
3. Use `/home/developer/dev` as workspace

### VS Code
1. Install "Remote - SSH" extension
2. Connect via SSH: `localhost:2222`
3. Open `/home/developer/dev` folder

### Dev Containers
1. Install "Dev Containers" extension
2. Use `docker-compose.yml` directly
3. VS Code will handle the rest

## 📊 Monitoring

### Resource Usage
```bash
# Container stats
docker stats daily-dev-container

# Disk usage
docker system df
```

### Health Checks
```bash
# Check container health
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

## 🔄 Updates

### Updating Images
```bash
# Pull latest images
./01_pull_images.sh

# Recreate containers
docker-compose up -d --force-recreate
```

### Updating Configuration
```bash
# After changing .env
docker-compose down
docker-compose up -d
