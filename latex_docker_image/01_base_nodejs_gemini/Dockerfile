# Layer 01: Base + Node.js + Gemini CLI
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV TIMEZONE=Europe/Zurich

# Essential packages (no openssh-server)
RUN apt-get update && apt-get install -y 
    git 
    curl 
    wget 
    vim 
    nano 
    sudo 
    zip 
    unzip 
    xz-utils 
    && apt-get clean 
    && rm -rf /var/lib/apt/lists/*

# Set timezone
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime 
    && echo "$TIMEZONE" > /etc/timezone 
    && dpkg-reconfigure -f noninteractive tzdata

# Create developer user
RUN userdel -r ubuntu || true
RUN useradd -u 1000 -m -s /bin/bash developer 
    && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/developer

USER developer
WORKDIR /home/developer

# Install Node.js
COPY scripts/setup_nodejs.sh /home/developer/setup_nodejs.sh
RUN bash /home/developer/setup_nodejs.sh && rm /home/developer/setup_nodejs.sh

# Install Gemini CLI
USER root
COPY scripts/install_gemini_cli.sh /usr/local/bin/install_gemini_cli.sh
RUN chmod +x /usr/local/bin/install_gemini_cli.sh
USER developer
RUN /usr/local/bin/install_gemini_cli.sh

# Default shell
CMD ["/bin/bash"]
