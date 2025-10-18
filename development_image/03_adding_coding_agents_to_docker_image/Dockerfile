# Layer 03: Coding Agents
# Purpose: Build on top of Level 02 (dev environments) and install initial coding agent tooling.
# In this iteration we add the Gemini CLI and Qwen Code CLI following the official instructions.
# Additionally, we add OpenAI Codex CLI, Claude Code CLI, and Grok CLI.

# Keep the same simple ARG/IMAGE_VERSION pattern as layer 02 for consistency.
ARG IMAGE_VERSION=1.0.0
FROM development-level02-dev-environments:${IMAGE_VERSION}

# Ensure noninteractive to avoid tzdata prompts, etc.
ENV DEBIAN_FRONTEND=noninteractive

# We will install the CLIs globally via npm. Node.js and npm are already installed in layer 02.
# Switch to developer user to install packages with correct ownership
USER developer

# Create directory for installation scripts in developer home
RUN mkdir -p /home/developer/dump

# Copy the installer scripts into the developer home directory.
# Each script is responsible for installing a specific CLI using npm and verifying installation.
COPY scripts/install_gemini_cli.sh /home/developer/dump/install_gemini_cli.sh
COPY scripts/install_qwen_code.sh /home/developer/dump/install_qwen_code.sh
COPY scripts/install_openai_codex.sh /home/developer/dump/install_openai_codex.sh
COPY scripts/install_claude_code.sh /home/developer/dump/install_claude_code.sh
COPY scripts/install_grok_cli.sh /home/developer/dump/install_grok_cli.sh
COPY scripts/install_speckit.sh /home/developer/dump/install_speckit.sh
COPY scripts/install_cline.sh /home/developer/dump/install_cline.sh

# Set correct permissions for the scripts
USER root
RUN chmod +x /home/developer/dump/install_gemini_cli.sh \
    /home/developer/dump/install_qwen_code.sh \
    /home/developer/dump/install_openai_codex.sh \
    /home/developer/dump/install_claude_code.sh \
    /home/developer/dump/install_grok_cli.sh \
    /home/developer/dump/install_speckit.sh \
    /home/developer/dump/install_cline.sh

# Install the NPM packages as user developer    
USER developer

# Execute the installer scripts as developer user so all files are owned by developer.
# The scripts will:
# - Install each CLI globally
# - Verify the commands are on PATH
# - Print their versions to fail fast if something is wrong
RUN /home/developer/dump/install_gemini_cli.sh
RUN /home/developer/dump/install_qwen_code.sh
RUN /home/developer/dump/install_openai_codex.sh
RUN /home/developer/dump/install_claude_code.sh
RUN /home/developer/dump/install_grok_cli.sh
RUN /home/developer/dump/install_speckit.sh
RUN /home/developer/dump/install_cline.sh

# Switch back to the developer user to match the convention from previous layers for runtime.
USER developer
WORKDIR /home/developer

# Expose SSH port for consistency with the stack (inherited entrypoint comes from layer 01).
EXPOSE 22

# Expose port for OpenAI Codex authentication (as per CLI docs).
EXPOSE 1455

# Entry point is inherited from level 01 via level 02: /usr/local/bin/entrypoint_base_software_image.sh
# No change needed here; we rely on the same entrypoint to keep the image behavior consistent.
