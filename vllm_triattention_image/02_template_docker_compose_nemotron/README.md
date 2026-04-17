# Nemotron-Cascade-2-30B-A3B-NVFP4 + TriAttention (vLLM)

This directory contains a production-ready environment for running the **Nemotron-Cascade-2-30B-A3B-NVFP4** model using a custom vLLM image enhanced with **TriAttention** for efficient long-context reasoning.

## Overview

This setup leverages:
1.  **vLLM**: High-performance LLM inference engine.
2.  **TriAttention**: A trigonometric KV cache compression plugin that allows for significantly larger context windows (up to 256k+) with reduced memory overhead.
3.  **NVFP4 Weights**: Native support for Blackwell-optimized FP4 weights.

## Configuration

The main configuration is in `docker-compose.yml`.

### Key Features

- **Layered Build**: Automatically builds the `vllm-triattention` image from the adjacent `01_vllm_triattention` directory.
- **Persistent Cache**: Volumes for both HuggingFace models (`~/.cache/huggingface`) and TriAttention statistics (`~/.cache/triattention`).
- **Blackwell Optimized**: Includes specific environment variables for RTX 5090 stability and throughput.

### TriAttention Runtime Settings

- `TRIATTN_RUNTIME_KV_BUDGET`: Controls the compression aggressiveness.
- `TRIATTN_RUNTIME_SPARSE_STATS_PATH`: Points to the precomputed statistics required for the model's Transformer layers.

## Usage

### 1. Preparation
Ensure you have the statistics file for Nemotron-Cascade-2 in your `~/.cache/triattention/stats/` directory as specified in the `docker-compose.yml`.

### 2. Launch
```bash
./01_docker_compose_up.sh
```

### 3. Testing
We provide a Python-based test suite:
1.  Create the environment: `./00_b_create_conda_env.sh`
2.  Install packages: `./00_c_install_packages.sh` (after activating the env)
3.  Run the test: `python 04_test_vllm_python.py`

## Troubleshooting

- **OOM Errors**: If you encounter Out-of-Memory errors, try reducing `max-model-len` or the `gpu-memory-utilization` in `docker-compose.yml`.
- **Plugin Activation**: Verify the plugin is active by checking the container logs: `docker compose logs -f`.
