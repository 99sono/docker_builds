# Level 02 Verification Suite

## Verification Scripts
1. `01_A_run_built_container_entrypoint_script.sh` - Start Level 02 container
2. `02_check_container_access.sh` - Verify docker exec access
3. `03_verify_java_install.sh` - Java 21 validation
4. `04_verify_miniforge_install.sh` - Miniforge/Python 3.14 check
5. `05_verify_nodejs_install.sh` - Node.js 24.19 (via conda) validation
6. `06_verify_build_tools.sh` - Essential build tools check

## Execution Workflow
```bash
# Run all verifications (starts container, runs checks, stops container)
./00_run_all_verifications.sh

# Or manually:
# 1. Start container
./01_A_run_built_container_entrypoint_script.sh

# 2. Run verification scripts (in numerical order)
for script in 02_*.sh 03_*.sh 04_*.sh 05_*.sh 06_*.sh; do
    echo "=== Running $script ==="
    ./$script || echo "❌ Verification failed in $script"
    echo ""
done

# 3. Check final status
echo "=== Verification complete ==="
```
