# Layer 03: Coding Agents
# Purpose: Build on top of Level 02 (dev environments) and install initial coding agent tooling.
# In this iteration we add the Gemini CLI following the official instructions.
# Additionally, we add the Qwen Code CLI (qwen) following official instructions.

# Keep the same simple ARG/IMAGE_VERSION pattern as layer 02 for consistency.
ARG IMAGE_VERSION=1.0.0
FROM development-level02-dev-environments:${IMAGE_VERSION}

# Ensure noninteractive to avoid tzdata prompts, etc.
ENV DEBIAN_FRONTEND=noninteractive

# We will install the Gemini CLI globally via npm. Node.js and npm are already installed in layer 02.
# We keep installation scripts in /usr/local/bin for consistency with prior layers.
USER root

# Copy the Gemini installer script into the image.
# The script is responsible for installing @google/gemini-cli using npm and verifying installation.
COPY scripts/install_gemini_cli.sh /usr/local/bin/install_gemini_cli.sh
# Copy the Qwen Code installer script into the image.
# The script is responsible for installing @qwen-code/qwen-code using npm and verifying installation.
COPY scripts/install_qwen_code.sh /usr/local/bin/install_qwen_code.sh

# Set correct permissions for the scripts
RUN chmod +x /usr/local/bin/install_gemini_cli.sh /usr/local/bin/install_qwen_code.sh

# Execute the installer scripts as root because global npm installs typically target /usr/local.
# The scripts will:
# - Install @google/gemini-cli and @qwen-code/qwen-code globally
# - Verify 'gemini' and 'qwen' are on PATH
# - Print their versions to fail fast if something is wrong
RUN /usr/local/bin/install_gemini_cli.sh
RUN /usr/local/bin/install_qwen_code.sh

# Switch back to the developer user to match the convention from previous layers for runtime.
USER developer
WORKDIR /home/developer

# Expose SSH port for consistency with the stack (inherited entrypoint comes from layer 01).
EXPOSE 22

# Entry point is inherited from level 01 via level 02: /usr/local/bin/entrypoint_base_software_image.sh
# No change needed here; we rely on the same entrypoint to keep the image behavior consistent.
