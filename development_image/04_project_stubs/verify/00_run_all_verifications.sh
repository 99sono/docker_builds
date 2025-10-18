#!/usr/bin/env bash
#
# 10_run_all_verifications.sh
#
# Purpose:
#   Run all verification scripts for the Level 04 project stubs image in sequence.
#   This script orchestrates the complete verification process and handles cleanup at the end.
#
# Behavior:
#   - Sources common environment variables for consistent configuration.
#   - Starts with building and running the container.
#   - Runs verification scripts 02 through 03 in order.
#   - Runs cleanup script at the end.
#   - Fails fast if any verification step fails.
#   - Provides clear progress reporting.
#
# Verification Scripts Run:
#   - 02_enter_test_dev_container.sh
#   - 03_verify_project_stubs.sh
#   - 04_cleanup.sh (cleanup at the end)
#

# Fail fast: -e exit on error, -u error on unset var, -o pipefail fail on first error in pipelines
set -euo pipefail

# Source common environment variables
source ../../00_common_env.sh

echo "=================================================="
echo "🔍 COMPREHENSIVE VERIFICATION: PROJECT STUBS IMAGE"
echo "=================================================="
echo "[verify-all] Starting complete verification process..."
echo "[verify-all] IMAGE_VERSION=${IMAGE_VERSION}"
echo "[verify-all] Container: ${TEST_CONTAINER_NAME}"
echo ""

# Step 1: Build and run the container
echo "=================================================="
echo "📦 STEP 1: Build and Run Container"
echo "=================================================="
echo "[verify-all] Running build and run script..."
./01_A_build_and_run.sh
echo "[verify-all] ✅ Container built and started successfully"
echo ""

# Step 2: Run all verification scripts in order
echo "=================================================="
echo "🔍 STEP 2: Run All Verifications"
echo "=================================================="

# Array of verification scripts to run (automated testing - no interactive scripts)
verification_scripts=(
    "02_check_container_access.sh"  # Non-interactive container access test
    "03_verify_project_stubs.sh"
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

# Step 3: Run cleanup
echo "=================================================="
echo "🧹 STEP 3: Cleanup"
echo "=================================================="
echo "[verify-all] Running cleanup script..."
./04_cleanup.sh
echo "[verify-all] ✅ Cleanup completed successfully"
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
    echo "[verify-all] ✅ Project stubs image is working correctly"
fi

echo "=================================================="
echo "[verify-all] Verification process completed"
echo "=================================================="
