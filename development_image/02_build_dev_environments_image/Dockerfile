# Use Level 01 as base image
ARG IMAGE_VERSION=1.0.0
FROM development-level01-basic-software:${IMAGE_VERSION}

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Start as user root
USER root

# Install all system-level dependencies in a single layer.
# build-essential: gcc/g++, make, essential build tools.
#   Required for Python C extensions, Node.js native modules, Java JNI libraries.
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    openjdk-21-jdk \
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

# Run setup scripts in order: miniforge first (provides conda), then nodejs (uses conda)
RUN /usr/local/bin/setup_miniforge3.sh \
    && /usr/local/bin/setup_nodejs.sh

# Expose SSH port
EXPOSE 22

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/entrypoint_base_software_image.sh"]
