# Development Environments Image (Level 02)

This layer builds on the base image to provide a complete development environment with multiple programming languages and tools.

## Development Environments

### Java Development
- OpenJDK 17
- Pre-configured JAVA_HOME and PATH
- Maven build system
- Sample project structure

### Python Development
- Miniforge3 installation in ~/programs/miniforge3
- Conda environment management
- pip package manager
- Development tools:
  - pytest for testing
  - black for code formatting
  - flake8 for linting
  - mypy for type checking

### Node.js Development
- Node.js 20.x in ~/programs/node
- npm package manager
- TypeScript support
- Development tools:
  - Jest for testing
  - ESLint for linting
  - Prettier for formatting

## Prerequisites

- Base image (development-level01-basic-software:1.0.0) must be built first
- Docker with sufficient disk space (~2GB)

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
conda create -n myproject python=3.11
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
- Modify conda environment settings in setup_python_env.sh
- Add custom packages to requirements.txt

### Node.js Setup
- Adjust Node.js version in setup_node_env.sh
- Modify default npm packages in package.json

### Java Configuration
- Configure Maven settings in settings.xml
- Adjust JVM options in environment variables