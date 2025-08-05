# Layer 03 — Adding Coding Agents to Docker Image

## Purpose
This layer builds on top of the Level 02 “dev environments” image to progressively add AI coding agents and their CLIs. In this iteration, we integrate the Google Gemini CLI as the first coding agent component. Future iterations will add Aider and Qwen Code.

This follows the project’s layered approach:
- Level 01: Base software
- Level 02: Development environments (Java, Node.js, Python via Miniforge, build tools)
- Level 03: Coding agents (this layer; starts with Gemini CLI)
- Level 04: Project stubs and final assembly

## What’s included in this layer (Phase 1)
- Installation of the Gemini CLI using npm, following the official documentation.
- Build and verification scripts to ensure the `gemini` command is present and usable in the container.
- Documentation on how this fits into the layered build.

## Gemini CLI — Installation
Inside the container image, the Gemini CLI is installed globally with npm:
```bash
npm install -g @google/gemini-cli
```

Reference: https://github.com/google-gemini/gemini-cli

Notes:
- Node.js and npm come from Level 02 (dev environments), so this layer can install the CLI globally.
- The CLI expects GEMINI_API_KEY at runtime for real API calls. This layer’s verification only checks command presence and version.

## Layered Build Structure
This layer uses the Level 02 image as its base. The Dockerfile mirrors the conventions from `development_image/02_build_dev_environments_image/Dockerfile`:
- Uses `ARG IMAGE_VERSION` with a default (e.g., `1.0.0`)
- `FROM development-level02-dev-environments:${IMAGE_VERSION}`

The build script mirrors `02_build_dev_environments_image/build.sh`:
- Sources common environment variables from `../00_common_env.sh`
- Tags the image with: `${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}`

## Files in this layer
- Dockerfile: Builds on Level 02 and installs the Gemini CLI.
- scripts/install_gemini_cli.sh: Installs and verifies the CLI in a fail-fast manner.
- build.sh: Builds the Level 03 image, following the Layer 02 build style.
- verify/: Scripts to run a test container, exec into it, and verify that `gemini` is available.

## Build Instructions
From this directory:
```bash
./build.sh
```
Optional:
```bash
IMAGE_VERSION=1.0.0 ./build.sh
```
This will produce an image tagged as:
```
${IMAGE_NAME_SUFFIX_CODING_AGENTS}:${IMAGE_VERSION}
```
where `IMAGE_NAME_SUFFIX_CODING_AGENTS` is defined in `development_image/00_common_env.sh` (e.g., `development-level03-coding-agents`).

## Verify Instructions
A minimal set of scripts will be provided in `verify/`:
1) Run a test container from the newly built image.
2) Exec into the container (manual step, optional).
3) Verify `gemini` is on the PATH and prints a version.

These scripts are modeled after the verification approach in Level 02 to keep a consistent developer experience.

## Runtime API Keys
For real usage:
- GEMINI_API_KEY: Required by the gemini CLI for API interactions. Not required for the “presence/version check” done in verification.
- OPENROUTER_API_KEY: Reserved for agents that might route via OpenRouter (future iterations for Aider/Qwen). Not used by the Gemini CLI itself.

Compose templates (in `05_docker_compose_template`) include these environment variables to make it simple to pass them into containers when you need them.

## Roadmap (Progressive Integration)
- Phase 1 (this iteration): Gemini CLI installation and verification.
- Phase 2: Add Aider with its configuration and verification.
- Phase 3: Add Qwen Code with its configuration and verification.
- Phase 4: Polish, performance tweaks, and integrated examples.
