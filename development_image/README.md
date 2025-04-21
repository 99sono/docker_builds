# Development Docker Images

This project provides a modular set of Docker images for development environments. The images are built in layers to maintain modularity and keep image sizes manageable.

## Structure

- `01_build_base_software_image`: Base layer with system utilities and SSH setup
- `02_build_dev_environments_image`: Development environments layer with Java, Python (Miniforge3), and Node.js
- `03_project_stubs`: Minimal project stubs for each development environment

## Quick Start

1. Build the base image:
```bash
cd 01_build_base_software_image
./build.sh
```

2. Build the development environments image:
```bash
cd ../02_build_dev_environments_image
./build.sh
```

3. Build the project stubs image:
```bash
cd ../03_project_stubs
./build.sh
```

4. Run a container:
```bash
docker run -d -p 2222:22 --name dev-container development-level03-project-stubs:1.0.0
```

5. Add your SSH key:
```bash
docker cp ~/.ssh/id_rsa.pub dev-container:/home/developer/.ssh/authorized_keys
```

6. Connect via SSH:
```bash
ssh -p 2222 developer@localhost
```

## Features

### Base Image (Level 01)
- Ubuntu-based with essential system utilities
- Secure SSH setup
- Git with branch display in prompt
- Developer user with sudo privileges

### Development Environments (Level 02)
- Java (OpenJDK 17)
- Python via Miniforge3 (in ~/programs/miniforge3)
- Node.js 20.x (in ~/programs/node)

### Project Stubs (Level 03)
- Minimal project templates for each environment
- No dependencies or package installations
- Ready-to-use project structures:
  - Java: Maven-based projects with minimal pom.xml
  - Node.js: Basic npm projects with package.json
  - Python: Simple Python projects with empty requirements.txt

## Configuration

Environment variables can be configured in `00_common_env.sh`:
- Image names and versions
- Timezone settings

## Security

- Root login disabled
- Password authentication disabled
- SSH key-based authentication only
- Non-root user with sudo privileges

## Contributing

- Follow the modular structure when adding new features
- Keep Dockerfiles clean and optimized
- Document changes in respective README files


