# vLLM with TriAttention Support

This directory contains the configuration for a production-ready vLLM image enhanced with the **TriAttention** plugin. TriAttention provides trigonometric KV cache compression, significantly reducing memory usage and increasing throughput for long-context models.

## Structure

- **`00_common_env.sh`**: Shared environment variables and image naming conventions.
- **`01_vllm_triattention/`**: Contains the Dockerfile that layers TriAttention on top of `vllm/vllm-openai:latest`.
- **`02_template_docker_compose_nemotron/`**: A template `docker-compose.yml` demonstrating how to use the enhanced image with Nemotron-Cascade-2.
- **`scripts/`**: Automation scripts for building and verifying the images.

## Features

- **Automatic Activation**: The TriAttention plugin uses vLLM's internal entry point system to activate automatically upon installation.
- **Optimized for Blackwell (RTX 5090)**: Configured with stability overrides and memory utilization settings specifically for high-end hardware.
- **Long-Context Efficiency**: Enables stable execution of models like Nemotron-Cascade-2 with context lengths up to 256k+ tokens.

## Usage

### 1. Build the Image
```bash
cd scripts
./build_all.sh
```

### 2. Launch with Docker Compose
Navigate to the template directory and start the service:
```bash
cd ../02_template_docker_compose_nemotron
docker-compose up -d
```

## Runtime Environment Variables

- `TRIATTN_RUNTIME_KV_BUDGET`: Sets the token budget for KV cache compression.
- `TRIATTN_RUNTIME_SPARSE_STATS_PATH`: Path to the precomputed statistics file (stored in the persistent cache volume).
