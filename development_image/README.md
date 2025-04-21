# Development Docker Images

This project provides a modular set of Docker images for development environments. The images are built in layers to maintain modularity and keep image sizes manageable.

## Structure

- `01_build_base_software_image`: Base layer with system utilities and SSH setup
- `02_build_dev_environments_image`: Development environments layer with Java, Python (Miniforge3), and Node.js

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

3. Run a container:
```bash
docker run -d -p 2222:22 --name dev-container development-level02-dev-environments:1.0.0
```

4. Add your SSH key:
```bash
docker cp ~/.ssh/id_rsa.pub dev-container:/home/developer/.ssh/authorized_keys
```

5. Connect via SSH:
```bash
ssh -p 2222 developer@localhost
```

## Features

### Base Image (Level 01)
- Ubuntu-based with essential system utilities
- Secure SSH setup
- Git with branch display in prompt
- Workspace structure for different programming languages

### Development Environments (Level 02)
- Java (OpenJDK 17)
- Python via Miniforge3 (in ~/programs)
- Node.js 20.x (in ~/programs)
- Full development environment configurations

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


