# TriAttention layer on top of official vLLM
# Optimized for RTX 5090 (Blackwell) + WSL2 – April 2026
# Adds trigonometric KV cache compression plugin

ARG VLLM_BASE_IMAGE=vllm/vllm-openai:latest
FROM ${VLLM_BASE_IMAGE}

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Directories for TriAttention stats/cache and Triton JIT cache
ENV TRIATTN_STATS_DIR=/root/.cache/triattention/stats
ENV TRITON_CACHE_DIR=/root/.cache/.triton-cache

# Install minimal system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create cache directories
RUN mkdir -p ${TRIATTN_STATS_DIR} ${TRITON_CACHE_DIR}

# ── Install TriAttention vLLM plugin ───────────────────────────────────────
# This plugin provides powerful trigonometric KV cache compression.
# It auto-activates via vLLM's entry_points system once installed.
#
# flash-attn is DISABLED because compilation consistently crashes/freeze WSL2
# on Blackwell (RTX 5090). The official vLLM image already includes
# compatible Triton-based Flash Attention and internal kernels.
RUN pip install --no-cache-dir git+https://github.com/WeianMao/triattention.git
# RUN pip install --no-cache-dir flash-attn --no-build-isolation   # ← DISABLED (causes WSL2 crashes)

# Blackwell + WSL2 stability settings
ENV VLLM_FLASH_ATTN_VERSION=2
ENV TORCH_CUDA_ARCH_LIST="12.0"

# NOTE: The TriAttention plugin activates automatically.
# Runtime configuration (KV budget, stats path, etc.) is done in docker-compose.yml

# Keep original vLLM working directory and entrypoint
WORKDIR /vllm-workspace

ENTRYPOINT ["python3", "-m", "vllm.entrypoints.openai.api_server"]