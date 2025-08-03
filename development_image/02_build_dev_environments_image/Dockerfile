# Use Level 01 as base image
ARG IMAGE_VERSION=1.0.0
FROM development-level01-basic-software:${IMAGE_VERSION}

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH


# Start as user root
USER root

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
    openjdk-21-jdk \
    maven \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy setup scripts
COPY scripts/setup_miniforge3.sh /usr/local/bin/setup_miniforge3.sh
COPY scripts/setup_nodejs.sh /usr/local/bin/setup_nodejs.sh

# Set permissions
RUN chmod +x /usr/local/bin/setup_miniforge3.sh /usr/local/bin/setup_nodejs.sh

# Install build-essential: Provides gcc/g++, make, and essential build tools
# Required for:
# - Python packages with C extensions (numpy, scipy, pandas)
# - Node.js native modules (node-gyp, bcrypt, sharp)
# - Java JNI native libraries
# - Any source compilation during development
RUN apt install build-essential

# Switch to developer user for installations
USER developer
WORKDIR /home/developer

# Run setup scripts
RUN /usr/local/bin/setup_miniforge3.sh \
    && /usr/local/bin/setup_nodejs.sh

# Expose SSH port
EXPOSE 22

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/entrypoint_base_software_image.sh"]
