# Use the official vLLM OpenAI-compatible image as the base
ARG VLLM_BASE_IMAGE=vllm/vllm-openai:latest
FROM ${VLLM_BASE_IMAGE}

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
# TriAttention requires some precomputed stats; we prepare a directory for them
ENV TRIATTN_STATS_DIR=/root/.cache/triattention/stats

# Install system dependencies required for building/installing plugins
RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install TriAttention vLLM plugin
# This plugin provides trigonometric KV cache compression for memory efficiency.
# It uses the standard vLLM plugin system (entry_points) to auto-activate.
RUN pip install --no-cache-dir git+https://github.com/WeianMao/triattention.git

# Create directory for TriAttention statistics and cache
RUN mkdir -p ${TRIATTN_STATS_DIR}

# NOTE: The plugin activates automatically once installed in the Python environment.
# Runtime configuration is handled via environment variables in docker-compose.

# Ensure the working directory is set to root (default for vLLM image)
WORKDIR /vllm-workspace

# The entrypoint remains the same as the base vLLM image
ENTRYPOINT ["python3", "-m", "vllm.entrypoints.openai.api_server"]
