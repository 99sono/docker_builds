# Use Level 01 as base image
FROM development-level01-basic-software:1.0.0

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install development tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create programs directory
RUN mkdir -p /home/developer/programs \
    && chown developer:developer /home/developer/programs \
    && chmod 755 /home/developer/programs

# Install Java Development Kit
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy setup scripts
COPY scripts/setup_miniforge3.sh /usr/local/bin/setup_miniforge3.sh
COPY scripts/setup_nodejs.sh /usr/local/bin/setup_nodejs.sh

# Set permissions
RUN chmod +x /usr/local/bin/setup_miniforge3.sh /usr/local/bin/setup_nodejs.sh

# Switch to developer user for installations
USER developer
WORKDIR /home/developer

# Run setup scripts
RUN /usr/local/bin/setup_miniforge3.sh \
    && /usr/local/bin/setup_nodejs.sh

# Switch back to root for SSH service
USER root

# Expose SSH port (inherited from base)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]