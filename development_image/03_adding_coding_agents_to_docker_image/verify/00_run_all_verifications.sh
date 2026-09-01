#!/usr/bin/env bash
#
# 00_run_all_verifications.sh
#
# Purpose:
#   Run all verification scripts for the Level 03 coding agents image in sequence.
#   This script orchestrates the complete verification process and stops the container at the end.
#
# Verification Scripts Run:
#   - 02_check_container_access.sh
#   - 05_verify_openai_codex.sh
#   - 06_verify_opencode.sh
#   - 07_verify_antigravity.sh
#   - 08_verify_rtk.sh
#   - 09_verify_cline.sh
#
set -euo pipefail

# Source common environment variables
source ../../00_common_env.sh

echo "=================================================="
echo "🔍 COMPREHENSIVE VERIFICATION: CODING AGENTS IMAGE"
echo "=================================================="
echo "[verify-all] Starting complete verification process..."
echo "[verify-all] IMAGE_VERSION=${IMAGE_VERSION}"
echo "[verify-all] Container: ${TEST_CONTAINER_NAME}"
echo ""

# Step 1: Run the container entrypoint script
echo "=================================================="
echo "📦 STEP 1: Start Container"
echo "=================================================="
echo "[verify-all] Running container entrypoint script..."
./01_A_run_built_container_entrypoint_script.sh
echo "[verify-all] ✅ Container started successfully"
echo ""

# Step 2: Run all verification scripts in order
echo "=================================================="
echo "🔍 STEP 2: Run All Verifications"
echo "=================================================="

# Array of verification scripts to run (automated testing - no interactive scripts)
verification_scripts=(
    "02_check_container_access.sh"
    "05_verify_openai_codex.sh"
    "06_verify_opencode.sh"
    "07_verify_antigravity.sh"
    "08_verify_rtk.sh"
    "09_verify_cline.sh"
)

failed_verifications=()
passed_verifications=()

for script in "${verification_scripts[@]}"; do
    echo "--------------------------------------------------"
    echo "🧪 Running: $script"
    echo "--------------------------------------------------"

    if ./$script; then
        echo "[verify-all] ✅ $script PASSED"
        passed_verifications+=("$script")
    else
        echo "[verify-all] ❌ $script FAILED"
        failed_verifications+=("$script")
    fi
    echo ""
done

# Step 3: Stop the container
echo "=================================================="
echo "🛑 STEP 3: Stop Container"
echo "=================================================="
echo "[verify-all] Stopping container..."

CONTAINER_NAME="${TEST_CONTAINER_NAME}"
if docker ps -q --filter "name=${CONTAINER_NAME}" | grep -q .; then
    echo "[verify-all] Stopping container: ${CONTAINER_NAME}"
    docker stop "${CONTAINER_NAME}"
    echo "[verify-all] ✅ Container stopped successfully"
elif docker ps -a -q --filter "name=${CONTAINER_NAME}" | grep -q .; then
    echo "[verify-all] ⚠️  Container ${CONTAINER_NAME} exists but is not running"
else
    echo "[verify-all] ⚠️  Container ${CONTAINER_NAME} not found"
fi
echo ""

# Step 4: Summary
echo "=================================================="
echo "📊 VERIFICATION SUMMARY"
echo "=================================================="

echo "✅ PASSED (${#passed_verifications[@]}):"
for script in "${passed_verifications[@]}"; do
    echo "   • $script"
done

if [ ${#failed_verifications[@]} -gt 0 ]; then
    echo ""
    echo "❌ FAILED (${#failed_verifications[@]}):"
    for script in "${failed_verifications[@]}"; do
        echo "   • $script"
    done
    echo ""
    echo "[verify-all] ❌ SOME VERIFICATIONS FAILED"
    exit 1
else
    echo ""
    echo "[verify-all] 🎉 ALL VERIFICATIONS PASSED!"
    echo "[verify-all] ✅ Coding agents image is working correctly"
fi

echo "=================================================="
echo "[verify-all] Verification process completed"
echo "=================================================="
