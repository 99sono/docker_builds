# Project Stubs Image (Level 03)

This layer builds on the development environments image to provide minimal project stubs for Java, Python, and Node.js development.

## Project Templates

### Java Projects
- `dummy_java_project01` and `dummy_java_project02`
- Minimal Maven structure:
  - Basic `pom.xml` with only groupId, artifactId, version
  - `src/main/java` and `src/test/java` directories
  - Simple Main class

### Python Projects
- `dummy_python_project01` and `dummy_python_project02`
- Minimal structure:
  - Empty `requirements.txt` (add dependencies as needed)
  - Basic `main.py` with starter code

### Node.js Projects
- `dummy_node_project01` and `dummy_node_project02`
- Minimal structure:
  - Basic `package.json` with name and version
  - Simple `index.js` file

## Prerequisites

- Development environments image (development-level02-dev-environments:1.0.0) must be built first
- Docker with sufficient disk space

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
  development-level03-project-stubs:1.0.0
```

2. Configure SSH access:
```bash
docker cp ~/.ssh/id_rsa.pub dev-env:/home/developer/.ssh/authorized_keys
```

3. Connect:
```bash
ssh -p 2222 developer@localhost
```

## Development Workflow

### Java Projects
```bash
cd ~/dev/java/dummy_java_project01
# Add dependencies to pom.xml as needed
```

### Python Projects
```bash
cd ~/dev/python/dummy_python_project01
# Add dependencies to requirements.txt as needed
# Use conda to create environments when needed
```

### Node.js Projects
```bash
cd ~/dev/node/dummy_node_project01
# Add dependencies to package.json as needed
```

## Customization

- Each project is a minimal stub without dependencies
- Add dependencies and additional configuration as needed
- Projects are set up to be extended, not to be used as-is in production