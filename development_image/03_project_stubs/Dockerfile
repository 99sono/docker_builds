# Use dev environments image as base
FROM development-level02-dev-environments:1.0.0

# Copy setup script
COPY scripts/setup_projects.sh /usr/local/bin/setup_projects.sh

# Set permissions
RUN chmod +x /usr/local/bin/setup_projects.sh

# Create workspace directory
RUN mkdir -p /home/developer/dev \
    && chown developer:developer /home/developer/dev

# Switch to developer user for project setup
USER developer
WORKDIR /home/developer/dev

# Run project setup
RUN /usr/local/bin/setup_projects.sh

# Switch back to root for SSH service
USER root

# Expose SSH port (inherited from base)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]