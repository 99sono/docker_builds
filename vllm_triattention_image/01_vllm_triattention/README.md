# vLLM TriAttention Docker Image

This directory contains the Dockerfile and build logic for layering TriAttention support onto the official vLLM image.

## Build

To build the image manually:
```bash
./build.sh
```

## Details

- **Base Image**: `vllm/vllm-openai:latest`
- **Plugin**: [TriAttention](https://github.com/WeianMao/triattention)
- **Modifications**:
  - Installs `git` for plugin installation.
  - Installs `triattention` via pip from source.
  - Creates cache directories for precomputed stats.
