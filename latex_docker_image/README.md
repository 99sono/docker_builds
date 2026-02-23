# LaTeX + Gemini CLI Docker Image

This project provides a layered Docker build system for a comprehensive LaTeX environment integrated with the Gemini CLI.

## 📁 Structure

- `01_base_nodejs_gemini/`: Ubuntu 24.04 base with Node.js and Gemini CLI.
- `02_latex_env/`: Built on top of Layer 01, adds a full TeX Live installation and `latexmk`.

## 🚀 How to Build

To build all layers in sequence:
```bash
./scripts/build_all.sh
```

## ✅ How to Verify

To verify that all tools are correctly installed:
```bash
./scripts/verify_all.sh
```

## 🛠 Usage with VS Code

You can use the "Dev Containers: Attach to Running Container" feature in VS Code to work inside the container. 

Alternatively, create a `.devcontainer/devcontainer.json` in your CV project folder that points to the image:
`latex-level02-env:1.0.0`
