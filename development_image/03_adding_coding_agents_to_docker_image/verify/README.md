# Layer 03 Verification Suite

## Verification Scripts
1. `01_A_run_built_container_entrypoint_script.sh` - Start Level 03 container
2. `02_check_container_access.sh` - Verify docker exec access
3. `05_verify_openai_codex.sh` - OpenAI Codex CLI check
4. `06_verify_opencode.sh` - OpenCode CLI check
5. `07_verify_antigravity.sh` - Antigravity (agy) binary check
6. `08_verify_rtk.sh` - RTK binary check
7. `09_verify_cline.sh` - Cline CLI check

## Execution Workflow
```bash
# Run all verifications (starts container, runs checks, stops container)
./00_run_all_verifications.sh
```
