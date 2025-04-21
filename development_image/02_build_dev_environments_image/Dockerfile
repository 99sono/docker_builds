# Use Level 01 as base image
FROM development-level01-basic-software:1.0.0

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_VERSION=20.x

# Install development tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install Python
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Java Development Kit
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up Python virtual environment
RUN python3 -m venv /home/developer/dev/python/venv \
    && chown -R developer:developer /home/developer/dev/python

# Copy environment setup scripts
COPY scripts/setup_node_env.sh /usr/local/bin/
COPY scripts/setup_python_env.sh /usr/local/bin/
COPY scripts/setup_java_env.sh /usr/local/bin/

# Set execute permissions
RUN chmod +x /usr/local/bin/setup_node_env.sh \
    /usr/local/bin/setup_python_env.sh \
    /usr/local/bin/setup_java_env.sh

# Run environment setup scripts
RUN /usr/local/bin/setup_node_env.sh && \
    /usr/local/bin/setup_python_env.sh && \
    /usr/local/bin/setup_java_env.sh

# Set up environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${PATH}:/home/developer/dev/python/venv/bin"

USER developer
WORKDIR /home/developer/dev