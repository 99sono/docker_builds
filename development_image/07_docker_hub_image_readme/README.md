# 07 Docker Hub Image README

This folder contains documentation files for the published Docker Hub image.

## Purpose

Docker Hub allows you to document your repositories with README files that appear on the Docker Hub website. This helps users understand what your container images do and how to use them.

## Files

- **`dockerhub-image-description.md`** - The comprehensive documentation that gets published to Docker Hub. This file explains what the development environment image is, what it contains, and how to use it.

## Usage

When you publish a new version of the development image to Docker Hub, you can use the content from `dockerhub-image-description.md` as the repository's README on Docker Hub.

**For Future Updates:** To verify current software versions inside a running container, run these commands:

```bash
java --version
conda --version
python --version
node --version
lsb_release -a
grok --version
gemini --version
qwen --version
codex --version
```

**Source Repository:**
The build files and scripts that create this image are located in: https://github.com/99sono/docker_builds
