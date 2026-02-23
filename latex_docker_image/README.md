# LaTeX & Gemini CLI Development Environment

This project provides a layered Docker environment specifically designed for professional LaTeX document preparation (like CVs and academic papers) integrated with Google's Gemini CLI for AI-assisted writing and refinement.

## Why this exists?
1.  **Isolation:** TeX Live (especially `texlive-full`) is massive (5GB+). This image keeps your host system clean.
2.  **Portability:** A consistent compilation environment regardless of your OS (Windows/WSL2, Linux, macOS).
3.  **AI-Augmented:** Pre-installed Gemini CLI allows you to use LLMs to summarize experiences, fix grammar, or suggest LaTeX formatting directly from the terminal.

## Image Layers
- **Layer 01 (Base + Node.js):** Ubuntu 24.04 with Node.js and Gemini CLI.
- **Layer 02 (LaTeX):** Adds the full TeX Live suite and `latexmk`.
- **Layer 03 (Workspace):** Finalizes the environment with CV templates, a dedicated workspace folder, and a "welcome" documentation for the developer.

## Quick Start
1.  Navigate to `04_docker_compose/`.
2.  Copy `.env.example` to `.env` and add your `GEMINI_API_KEY`.
3.  Run `./02_start_dev.sh` to launch the environment.
4.  Use `./03_enter_cv_dev.sh` to start working.

Your personal CV source code should be placed in a local directory that is mounted into the container at `/home/developer/dev/`.
