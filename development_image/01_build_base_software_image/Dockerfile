# Use Ubuntu 25.04 as the base image
FROM ubuntu:25.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TIMEZONE=Europe/Zurich

# Install essential packages and clean up
RUN apt-get update && apt-get install -y \
    git git-lfs \
    net-tools curl wget tcpdump \
    htop procps psmisc \
    vim nano tmux zip unzip \
    logrotate cron \
    openssh-server \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo "$TIMEZONE" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# Remove the default ubuntu user (if it exists) to free up UID 1000
RUN userdel -r ubuntu || true

# Create developer user and set up home directory
RUN useradd -u 1000 -m -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/developer

# Set the password for the developer user
# Important: when a user has no assigned password logging in as this user is not possible
# even if the public/private key is uploaded correctly to server
RUN echo "developer:developer" | chpasswd

# Copy configuration files and scripts
COPY config/sshd_config /etc/ssh/sshd_config
COPY scripts/setup_ssh.sh /usr/local/bin/setup_ssh.sh
COPY scripts/entrypoint_base_software_image.sh /usr/local/bin/entrypoint_base_software_image.sh  

# Set permissions
RUN chmod +x /usr/local/bin/*.sh

# Configure Git branch prompt in .bashrc
RUN echo 'parse_git_branch() { git branch 2>/dev/null | grep "*" | sed "s/* //"; }' >> /home/developer/.bashrc \
    && echo 'PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0;33m\](\$(parse_git_branch))\[\e[0m\]\$ "' >> /home/developer/.bashrc

# Create empty authorized_keys file with proper permissions
RUN mkdir -p /home/developer/.ssh \
    && touch /home/developer/.ssh/authorized_keys \
    && chown -R developer:developer /home/developer/.ssh \
    && chmod 700 /home/developer/.ssh \
    && chmod 600 /home/developer/.ssh/authorized_keys


# Set ownership of home directory
RUN chown -R developer:developer /home/developer

## Ensure every Docker build finishes with the working directory set to the developer user's home directory.
# This is important for several reasons:
# 1. Users who log in to a bash shell should start in the developer's home directory.
# 2. For /etc/ssh/sshd_config, the AuthorizedKeysFile property is set to .ssh/authorized_keys,
#    so users must log in directly to their home directory for SSH key authentication to work as expected.

WORKDIR /home/developer


# Expose SSH port
EXPOSE 22

# Set the default user to developer
USER developer

# Set the entry point for the container
ENTRYPOINT ["/usr/local/bin/entrypoint_base_software_image.sh"]
