# Layer 02: LaTeX Environment
ARG IMAGE_VERSION=1.0.0
FROM latex-level01-base-gemini:${IMAGE_VERSION}

USER root
ENV DEBIAN_FRONTEND=noninteractive

# Install LaTeX (texlive-full is large but ensures no missing packages for CVs)
# Also installing latexmk which is very helpful for automated builds
RUN apt-get update && apt-get install -y \
    texlive-full \
    latexmk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER developer
WORKDIR /home/developer

# Ensure node/gemini are in path for developer
ENV PATH="/home/developer/programs/node/bin:${PATH}"

CMD ["/bin/bash"]
