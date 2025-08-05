# Use dev environments image as base
ARG IMAGE_VERSION=1.0.0
FROM development-level03-coding-agents:${IMAGE_VERSION}

# Start as user root
USER root

# Copy setup script
COPY scripts/setup_projects.sh /usr/local/bin/setup_projects.sh

# Set permissions
RUN chmod +x /usr/local/bin/setup_projects.sh

# Switch to developer user for project setup
USER developer

# Create workspace directory
RUN mkdir -p /home/developer/dev \
    && chown developer:developer /home/developer/dev


WORKDIR /home/developer/dev

# Run project setup
RUN /usr/local/bin/setup_projects.sh

# Expose SSH port
EXPOSE 22

# Set the default user to developer
USER developer

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/entrypoint_base_software_image.sh"]