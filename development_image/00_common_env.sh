#!/bin/bash
# Global environment variables for the development Docker images

# Base image naming suffixes
export IMAGE_NAME_SUFFIX_BASE_SOFTWARE="development-level01-basic-software"
export IMAGE_NAME_SUFFIX_DEV_ENVIRONMENTS="development-level02-dev-environments"
export IMAGE_NAME_SUFFIX_CODING_AGENTS="development-level03-coding-agents"
export IMAGE_NAME_SUFFIX_PROJECT_STUBS="development-level04-project-stubs"

# Name of container used to lunch images when testing them
export TEST_CONTAINER_NAME=test-dev-container

# Version number for images
export IMAGE_VERSION="1.0.0"

# Timezone setting for the container
export TIMEZONE="Europe/Zurich"

# Base Ubuntu version - LTS for stability
export UBUNTU_VERSION="24.04"
export UBUNTU_IMAGE="ubuntu:${UBUNTU_VERSION}"

# Runtime versions
export NODE_VERSION="20.11.1"
export JAVA_VERSION="17"
export PYTHON_VERSION="3.11"
export MAVEN_VERSION="3.9.6"

# Docker Hub repository information for publishing
export DOCKER_HUB_REPO_NAME="99sono/99sono-public-repo"
export DOCKER_HUB_TAG="dev-environment-1.0.0-SNAPSHOT"
