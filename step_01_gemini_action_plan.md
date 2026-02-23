# Action Plan: Create LaTeX & Gemini CLI Docker Image

This plan outlines the steps to create a new Dockerized environment specifically for LaTeX document preparation (like CVs) and Gemini CLI integration, following the layered architecture and "instruction manual" script philosophy of the existing `development_image`.

## 1. Project Structure
We will create a new top-level directory `latex_docker_image` with the following sub-structure:

```text
latex_docker_image/
├── 00_common_env.sh
├── 01_base_nodejs_gemini/
│   ├── Dockerfile
│   ├── build.sh
│   ├── scripts/
│   │   ├── setup_nodejs.sh
│   │   └── install_gemini_cli.sh
│   └── verify/
│       └── 01_verify_gemini.sh
├── 02_latex_env/
│   ├── Dockerfile
│   ├── build.sh
│   └── verify/
│       └── 01_verify_latex.sh
└── scripts/
    ├── build_all.sh
    └── verify_all.sh
```

## 2. Layered Implementation Strategy

### Layer 01: Base, Node.js, and Gemini CLI
*   **Base:** Ubuntu 24.04 LTS.
*   **User:** Create a `developer` user (UID 1000) with sudo privileges, consistent with the `development_image`.
*   **Node.js:** Install Node.js (v24.x or similar) in the developer's home directory.
*   **Gemini CLI:** Install `@google/gemini-cli` globally via npm.
*   **No SSH:** Unlike the main development image, SSH is omitted to keep the image focused. VS Code Remote Development can attach directly to the running container.

### Layer 02: LaTeX Environment
*   **Base:** Inherit from `latex-level01-base-gemini`.
*   **LaTeX:** Install `texlive-full` (to provide a comprehensive environment) or a curated set of packages (`texlive-latex-extra`, `texlive-fonts-recommended`, `texlive-bibtex-extra`). Given the desire to keep "massive" libraries in Docker, `texlive-full` is the safest bet for a complete CV-building environment.
*   **Tools:** Install `latexmk` and other utilities for automated building.

## 3. Detailed Steps

### Step 3.1: Environment Setup
*   Create `00_common_env.sh` to define image names like `latex-level01-base-gemini` and `latex-level02-env`.

### Step 3.2: Layer 01 Construction
*   Adapt `setup_nodejs.sh` and `install_gemini_cli.sh` from the existing project.
*   Create a `Dockerfile` that combines the base OS setup with these tools.

### Step 3.3: Layer 02 Construction
*   Create a `Dockerfile` focused on `apt-get install -y texlive-full`.
*   Add verification scripts to ensure `pdflatex` or `xelatex` is functional.

### Step 3.4: Automation Scripts
*   Create `build_all.sh` to trigger the builds in sequence.
*   Create `verify_all.sh` to run the verification tests for both layers.

## 4. Goals
*   **Isolation:** Keep the host system clean of TeX Live's multi-gigabyte footprint.
*   **Portability:** A single `docker build` (or pull) provides a ready-to-use CV development environment.
*   **Consistency:** Maintain the same user experience and directory layout as the main `development_image`.
