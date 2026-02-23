# Layer 03: Workspace & Templates
ARG IMAGE_VERSION=1.0.0
FROM latex-level02-env:${IMAGE_VERSION}

USER root

# Create the dev directory
RUN mkdir -p /home/developer/dev && chown developer:developer /home/developer/dev

# Copy resources directly to the developer home with correct ownership
# resources/templates -> /home/developer/templates
# resources/README.md -> /home/developer/README.md
COPY --chown=developer:developer resources/templates /home/developer/templates
COPY --chown=developer:developer resources/README.md /home/developer/README.md

# Ensure the template script is executable
RUN chmod +x /home/developer/templates/template_latex_cv_directory/compile.sh

USER developer
WORKDIR /home/developer

# Set path for node and gemini
ENV PATH="/home/developer/programs/node/bin:${PATH}"

CMD ["/bin/bash"]
