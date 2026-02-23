#!/bin/bash
# verify_latex.sh
source ../00_common_env.sh

echo "[verify_latex] Verifying LaTeX installation in container..."
docker run --rm "${IMAGE_NAME_SUFFIX_LATEX_ENV}:${IMAGE_VERSION}" bash -c "pdflatex --version && xelatex --version && latexmk --version"
