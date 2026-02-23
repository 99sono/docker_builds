#!/bin/bash
# verify_gemini.sh
source ../00_common_env.sh

echo "[verify_gemini] Verifying Node and Gemini CLI in container..."
docker run --rm "${IMAGE_NAME_SUFFIX_LATEX_BASE}:${IMAGE_VERSION}" bash -c "export PATH=/home/developer/programs/node/bin:\$PATH && node --version && gemini --version"
