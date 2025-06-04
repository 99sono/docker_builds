# Development Docker Image Build System

This repository contains a structured set of Dockerfiles and scripts for building development environments tailored for software development workflows. It includes base images, dev environment images, and project stubs for consistent and reproducible development setups.

## 📁 Directory Structure

- `development_image/`  
  Contains Dockerfiles and scripts for building development images:
  - `01_build_base_software_image/`  
    Base image with essential tools (Ubuntu, SSH, basic utilities).
  - `02_build_dev_environments_image/`  
    Dev environment image with Java, Node.js, Python, and tools.
  - `03_project_stubs/`  
    Image with project templates and workspace structure.

- `scripts/`  
  Utility scripts for container setup and execution.

## 🧰 Key Features

- **Modular Image Building**: Each directory represents a stage in the development image pipeline.
- **Consistent Environment**: Ensures reproducible development setups across teams.
- **SSH Access**: Pre-configured SSH for easy container interaction.
- **Workspace Structure**: Standardized directories for Python, Node.js, and Java projects.

## 🛠 How to Build Images

1. **Build Base Image**  
   ```bash
   cd development_image/01_build_base_software_image
   ./build.sh
   ```

2. **Build Dev Environments Image**  
   ```bash
   cd development_image/02_build_dev_environments_image
   ./build.sh
   ```

3. **Build Project Stubs Image**  
   ```bash
   cd development_image/03_project_stubs
   ./build.sh
   ```

## 🚀 How to Run a Container

1. **Run the Final Image**  
   ```bash
   cd development_image/scripts
   ./01_run_final_container.sh
   ```

2. **Access via SSH**  
   Connect to the container using SSH on port 2222:
   ```bash
   ssh developer@localhost -p 2222
   ```

## 📝 Notes

- Ensure Docker is installed and running.
- The `.aider.conf.yml` and `.aiderignore` files control Aider-specific behaviors (e.g., model selection, file ignores).
- The `.gitignore` file ensures development artifacts are not committed to version control.

## 📁 Additional Information

### Structure

- `01_build_base_software_image`: Base layer with system utilities and SSH setup
- `02_build_dev_environments_image`: Development environments layer with Java, Python (Miniforge3), and Node.js
- `03_project_stubs`: Minimal project stubs for each development environment

### Quick Start

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

### Features

#### Base Image (Level 01)
- Ubuntu-based with essential system utilities
- Secure SSH setup
- Git with branch display in prompt
- Developer user with sudo privileges

#### Development Environments (Level 02)
- Java (OpenJDK 17)
- Python via Miniforge3 (in ~/programs/miniforge3)
- Node.js 20.x (in ~/programs/node)

#### Project Stubs (Level 03)
- Minimal project templates for each environment
- No dependencies or package installations
- Ready-to-use project structures:
  - Java: Maven-based projects with minimal pom.xml
  - Node.js: Basic npm projects with package.json
  - Python: Simple Python projects with empty requirements.txt

### Configuration

Environment variables can be configured in `00_common_env.sh`:
- Image names and versions
- Timezone settings

### Security

- Root login disabled
- Password authentication disabled
- SSH key-based authentication only
- Non-root user with sudo privileges

