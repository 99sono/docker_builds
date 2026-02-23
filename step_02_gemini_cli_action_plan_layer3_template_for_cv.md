# Action Plan: Layer 03 - CV Templates and Workspace Setup

This plan outlines the steps to add a professional workspace layer to our LaTeX + Gemini CLI Docker image. This layer provides a "ready-to-go" environment for CV development.

## 1. Project Structure
We will add a new directory `03_cv_workspace` to the `latex_docker_image` folder:

```text
latex_docker_image/
├── 03_cv_workspace/
│   ├── Dockerfile
│   ├── build.sh
│   ├── scripts/
│   │   ├── setup_templates.sh
│   │   └── create_welcome_message.sh
│   └── templates/
│       └── template_latex_cv_directory/
│           ├── main.tex
│           ├── compile.sh
│           └── README.md
├── 04_docker_compose/
│   ├── docker-compose.yml
│   ├── .env.example
│   └── enter_cv_dev.sh
```

## 2. Layer 03 Implementation Details

### 2.1: Workspace Layout
*   **Templates Directory:** `~/templates/template_latex_cv_directory/` will contain a base LaTeX CV.
*   **Development Directory:** `~/dev/` (intended for mounting host directories from WSL2).
*   **Documentation:** A `README.md` in `~/` explaining how to use the environment.

### 2.2: LaTeX CV Template
*   A clean, modern `main.tex` using standard classes (or common packages like `moderncv` if preferred, but standard `article` with specific styling is safer for a "dummy").
*   A `compile.sh` script inside the template that uses `latexmk` (installed in Layer 02) to build the PDF.

### 2.3: Welcome Experience
*   A script to generate a `.bash_welcome` or update `.bashrc` to show a summary of available tools (Node, Gemini, LaTeX) and instructions on how to copy the template to the `~/dev` folder.

## 3. Tooling and Access

### 3.1: Docker Compose
*   Provide a `docker-compose.yml` that:
    *   Defines the service `latex-cv-env`.
    *   Maps a local directory (e.g., `./my_cv`) to `/home/developer/dev`.
    *   Passes `GEMINI_API_KEY` from a `.env` file.

### 3.2: Easy Entry Script
*   `enter_cv_dev.sh`: A shell script to simplify running `docker exec -it ... bash` with the correct user and environment.

## 4. Goals
*   **Instant Productivity:** No need to search for "how to compile" or "where to start".
*   **Seamless Integration:** Easy bridge between WSL2 (host) and LaTeX (container).
*   **Agent-Ready:** Gemini CLI is pre-installed and path-configured to help refine CV content.

## 5. Execution Strategy
1.  **Wait for Layer 02:** Ensure the massive `texlive-full` build completes.
2.  **Verify Layer 02:** Confirm `pdflatex` and `latexmk` are functional.
3.  **Build Layer 03:** Create the stubs and the final "User Experience" layer.
4.  **Test Deployment:** Use the new `docker-compose.yml` to verify the mount and compilation.
