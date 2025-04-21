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

# Create developer user and set up home directory
RUN useradd -m -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/developer

# Copy configuration files and scripts
COPY config/sshd_config /etc/ssh/sshd_config
COPY scripts/setup_ssh.sh /usr/local/bin/setup_ssh.sh
COPY scripts/setup_workspace.sh /usr/local/bin/setup_workspace.sh

# Set permissions for scripts
RUN chmod +x /usr/local/bin/setup_ssh.sh /usr/local/bin/setup_workspace.sh

# Configure Git branch prompt in .bashrc
RUN echo 'parse_git_branch() { git branch 2>/dev/null | grep "*" | sed "s/* //"; }' >> /home/developer/.bashrc \
    && echo 'PS1="\[\e[1;32m\]\u@\h:\[\e[1;34m\]\w\[\e[0;33m\](\$(parse_git_branch))\[\e[0m\]\$ "' >> /home/developer/.bashrc

# Set up SSH directory
RUN mkdir -p /home/developer/.ssh \
    && chown developer:developer /home/developer/.ssh \
    && chmod 700 /home/developer/.ssh

# Run workspace setup
RUN /usr/local/bin/setup_workspace.sh

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]