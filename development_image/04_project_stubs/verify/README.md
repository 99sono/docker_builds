# Verify Suite — Layer 04: Project Stubs

Purpose
This verify suite builds the Layer 04 image, starts a test container, and validates that the project stubs (Java/Node/Python) created by scripts/setup_projects.sh are present in the assembled image.

Conventions
- Image: development-level04-project-stubs:${IMAGE_VERSION:-1.0.0}
- Test container name: dev-test-level04
- Workspace base path: /home/developer/dev

Script sequence
1) 01_A_build_and_run.sh
   - Builds the Layer 04 image (via build.sh if present, otherwise docker build)
   - Removes any existing test container with the same name
   - Starts a new container: dev-test-level04

2) 02_enter_test_dev_container.sh
   - Opens an interactive shell inside the running test container (optional convenience)

3) 03_verify_project_stubs.sh
   - Verifies the presence of workspace and dummy projects:
     - Java: /home/developer/dev/java/dummy_java_project01 and 02
     - Node: /home/developer/dev/node/dummy_node_project01 and 02
     - Python: /home/developer/dev/python/dummy_python_project01 and 02
   - Performs light tool checks (java/javac, node, python)

4) 04_cleanup.sh (optional)
   - Removes the test container to keep the environment clean

Usage
From this directory:
```
./01_A_build_and_run.sh
./03_verify_project_stubs.sh
# optional:
./02_enter_test_dev_container.sh
./04_cleanup.sh
```

Notes
- You can override IMAGE_VERSION in your shell, e.g.:
  ```
  export IMAGE_VERSION=1.0.0
  ```
- If you change the container name or image tag, align it across scripts for consistency.
