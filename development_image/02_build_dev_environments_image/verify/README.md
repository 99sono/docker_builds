# Level 02 Verification Suite

## Verification Scripts
1. `01_A_run_built_container_entrypoint_script.sh` - Start Level 02 container
2. `03_verify_java_install.sh` - Java 17 validation
3. `04_verify_miniforge_install.sh` - Miniforge/Python check
4. `05_verify_nodejs_install.sh` - Node.js 20.x validation
5. `06_verify_build_tools.sh` - Essential build tools check

## Execution Workflow
```bash
# 1. Start container
./01_A_run_built_container_entrypoint_script.sh

# 2. Run verification scripts (in numerical order)
for script in 03_*.sh 04_*.sh 05_*.sh 06_*.sh; do
    echo "=== Running $script ==="
    ./$script || echo "❌ Verification failed in $script"
    echo ""
done

# 3. Check final status
echo "=== Verification complete ==="
```
