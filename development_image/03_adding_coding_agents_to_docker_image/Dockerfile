# Layer 03: Coding Agents
# Purpose: Build on top of Level 02 (dev environments) and install coding agent tooling.
# Agents: Cline, OpenCode, Antigravity, OpenAI Codex + RTK (shared prerequisite).

# Keep the same simple ARG/IMAGE_VERSION pattern as layer 02 for consistency.
ARG IMAGE_VERSION=1.0.0
FROM development-level02-dev-environments:${IMAGE_VERSION}

# Ensure noninteractive to avoid tzdata prompts, etc.
ENV DEBIAN_FRONTEND=noninteractive

# Switch to developer user to install packages with correct ownership
USER developer

# Create directory for installation scripts in developer home
RUN mkdir -p /home/developer/dump

# Copy the installer scripts into the developer home directory.
# Install order matters: RTK first (shared prerequisite), then agents.
# Each agent script also runs its own `rtk init` to register the plugin.
COPY scripts/install_rtk.sh /home/developer/dump/install_rtk.sh
COPY scripts/install_cline.sh /home/developer/dump/install_cline.sh
COPY scripts/install_opencode.sh /home/developer/dump/install_opencode.sh
COPY scripts/install_antigravity.sh /home/developer/dump/install_antigravity.sh
COPY scripts/install_codex.sh /home/developer/dump/install_codex.sh

# Set correct permissions for the scripts
USER root
RUN chmod +x /home/developer/dump/install_rtk.sh \
    /home/developer/dump/install_cline.sh \
    /home/developer/dump/install_opencode.sh \
    /home/developer/dump/install_antigravity.sh \
    /home/developer/dump/install_codex.sh

# Install the agents as developer user so all files are owned by developer.
# Order: RTK first, then agents (each agent registers its own RTK plugin).
USER developer

RUN /home/developer/dump/install_rtk.sh
RUN /home/developer/dump/install_cline.sh
RUN /home/developer/dump/install_opencode.sh
RUN /home/developer/dump/install_antigravity.sh
RUN /home/developer/dump/install_codex.sh

# Switch back to the developer user to match the convention from previous layers for runtime.
USER developer
WORKDIR /home/developer

# Expose SSH port for consistency with the stack (inherited entrypoint comes from layer 01).
EXPOSE 22

# Entry point is inherited from level 01 via level 02: /usr/local/bin/entrypoint_base_software_image.sh
# No change needed here; we rely on the same entrypoint to keep the image behavior consistent.
