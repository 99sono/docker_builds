# Task Objective: Refactor Verification Scripts for Docker Exec Compatibility

## Task Description
The verification scripts created for Level 02 were incorrectly designed to run inside the container rather than via `docker exec` commands like Level 01 scripts. We need to modify them to execute from the host against a running container, and also create a container startup script for Level 02.

## Resources for Context
- `development_image/02_build_dev_environments_image/Dockerfile`: Defines the environment to verify
- `development_image/01_build_base_software_image/verify/08_verify_sshd_config.sh`: Example of a host-executed verification script
- `development_image/01_build_base_software_image/verify/01_A_run_built_container_entrypoint_script.sh`: Example container startup script
- `prompt_engineering/01_sloppy_prompt_only_user_can_edit.md`: Original problem statement

## Action Plan
1. **Refactor Verification Scripts**  
   Modify existing Level 02 scripts to use `docker exec` commands instead of internal container checks

2. **Create Container Startup Script**  
   Make `01_A_run_built_container_entrypoint_script.sh` equivalent for Level 02

3. **Update README**  
   Ensure verification instructions match new execution method

## Detailed Step Instructions
### 1. Refactor Verification Approach
- Each script should:
  1. Start by sourcing common environment variables
  2. Use `docker exec ${TEST_CONTAINER_NAME}` to run commands
  3. Retrieve output/exit codes from container
  4. Make no assumptions about the container's internal state

### 2. Create Startup Script
- Should mirror Level 01's container startup process
- Must handle: build tagging, port mapping, entrypoint execution
- Support both normal entrypoint and debug modes

### Edge Cases to Consider
- Container may not be running
- Environment variables might be misconfigured
- Need to clean up old containers before testing
- Different image name/tag for Level 02
