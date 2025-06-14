#!/bin/bash
# Global environment variables for the development Docker images

# Base image naming suffixes
export IMAGE_NAME_SUFFIX_BASE_SOFTWARE="development-level01-basic-software"
export IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS="development-level02-dev-environments"
export IMAGE_NAME_SUFFIX_PROJECT_STUBS="development-level03-project-stubs"

# Name of container used to lunch images when testing them
export TEST_CONTAINER_NAME=test-dev-container

# Version number for images
export IMAGE_VERSION="1.0.0"

# Timezone setting for the container
export TIMEZONE="Europe/Zurich"
