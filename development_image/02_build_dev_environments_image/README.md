# Development Environments Image (Level 02)

This layer builds on the base image to provide a complete development environment with multiple programming languages and tools.

## Development Environments

### Java Development
- OpenJDK 21
- Pre-configured JAVA_HOME and PATH
- Maven build system

### Python Development
- Miniforge3 installation in ~/programs/miniforge3
- Conda environment management
- Python 3.14.7 in the base environment

### Node.js Development
- Node.js 24.19 installed via conda (in ~/programs/miniforge3/bin)
- npm package manager

## Prerequisites

- Base image (development-level01-basic-software:1.0.0) must be built first
- Docker with sufficient disk space (~3.4GB)

## Building

```bash
# From this directory
./build.sh
```

## Verification

```bash
cd verify
./00_run_all_verifications.sh
```

## Usage

1. Start a container:
```bash
docker run -d \
  -p 2222:22 \
  --name dev-env \
  development-level02-dev-environments:1.0.0
```

2. Configure SSH access (if not already done in base image):
```bash
docker cp ~/.ssh/id_rsa.pub dev-env:/home/developer/.ssh/authorized_keys
docker exec dev-env chown developer:developer /home/developer/.ssh/authorized_keys
docker exec dev-env chmod 600 /home/developer/.ssh/authorized_keys
```

3. Connect:
```bash
ssh -p 2222 developer@localhost
```

## Development Workflow

### Python Projects
```bash
cd ~/dev/python
conda create -n myproject python=3.14
conda activate myproject
pip install -r requirements.txt
```

### Node.js Projects
```bash
cd ~/dev/node
npm init
npm install typescript jest @types/jest --save-dev
```

### Java Projects
```bash
cd ~/dev/java
mvn archetype:generate
```

## Customization

### Python Environments
- Create custom conda environments as needed
- Install packages via conda or pip

### Node.js Setup
- Install global packages with `npm install -g` (installs into conda base env)
- Configure project-specific settings as needed

### Java Configuration
- Configure Maven settings in ~/.m2/settings.xml
- Set JVM options via JAVA_OPTS environment variable
