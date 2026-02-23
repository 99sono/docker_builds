#!/bin/bash
# Simple compilation script for the LaTeX CV

FILENAME="main"

echo "Compiling $FILENAME.tex..."

# Use latexmk for automated multi-pass compilation
# -pdf: Generate PDF
# -f: Force compilation
# -interaction=nonstopmode: Don't stop on errors
latexmk -pdf -f -interaction=nonstopmode "$FILENAME.tex"

echo "Cleaning up auxiliary files..."
latexmk -c

if [ -f "$FILENAME.pdf" ]; then
    echo "Success! $FILENAME.pdf has been generated."
else
    echo "Error: Failed to generate PDF."
    exit 1
fi
