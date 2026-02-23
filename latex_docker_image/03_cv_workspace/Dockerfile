# Layer 03: Workspace & Templates
ARG IMAGE_VERSION=1.0.0
FROM latex-level02-env:${IMAGE_VERSION}

USER root

# Copy templates and setup script
COPY templates /tmp/templates
COPY scripts/setup_templates.sh /usr/local/bin/setup_templates.sh
RUN chmod +x /usr/local/bin/setup_templates.sh

# Run the setup as root to ensure permissions but script handles chown
RUN /usr/local/bin/setup_templates.sh && rm -rf /tmp/templates

USER developer
WORKDIR /home/developer

# Set path for node and gemini (already in Layer 02 but reinforced)
ENV PATH="/home/developer/programs/node/bin:${PATH}"

CMD ["/bin/bash"]
