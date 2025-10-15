# 06 Publish to Public Repository

This folder contains scripts for publishing the final development container image to a public Docker Hub repository.

## Acknowledgments

This project was developed with assistance from [xAI's Grok LLM](https://x.ai) in cursor-mode.

## Current Approach: Manual Publishing

For now, we publish images manually from the development machine. This is a temporary "dirty" solution while we experiment with the containers.

### Prerequisites

1. **Docker Hub Account**: You need a Docker Hub account and repository created
2. **Local Build**: Images must be built locally first using `../scripts/build_all.sh`

### Publishing Steps

```bash
# 1. Build all images locally
cd ../..
./development_image/scripts/build_all.sh

# 2. Log in to Docker Hub (if not already logged in)
docker login

# 3. Tag the final image for Docker Hub
./development_image/06_publish_to_public_repo/01_tag_latest_created_image_before_publish_to_github.sh

# 4. Push the tagged image
./development_image/06_publish_to_public_repo/02_push_tagged_image_to_docker_hub.sh
```

### What Gets Published

The final image in the build chain (`development-level04-project-stubs:1.0.0`) gets tagged and pushed as:
```
99sono/99sono-public-repo/dev-environment:1.0.0-SNAPSHOT
```

Since we're using a `1.0.0-SNAPSHOT` tag, each publish operation overwrites the previous version. This keeps the repository clean while we experiment.

### Tag Management

Use the provided scripts to manage Docker tags:

```bash
# Delete old local tag before re-tagging
./development_image/06_publish_to_public_repo/03_delete_docker_hub_tag.sh --local

# For remote tag deletion (manual via Docker Hub web interface):
# Go to https://hub.docker.com/repository/docker/99sono/99sono-public-repo/dev-environment/tags
# Delete unwanted tags manually
```

## Future: Automated CI/CD Publishing

In the future, this process should be automated via GitHub Actions. You'll need to:

1. Add Docker Hub credentials as repository secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub access token (not password)

2. Update the GitHub workflow to include a publish step after successful builds

3. Add proper version tags instead of snapshot tags for stable releases

## Environment Variables

The publishing scripts use these environment variables from `../00_common_env.sh`:
- `DOCKER_HUB_REPO_NAME`: `99sono/99sono-public-repo`
- `DOCKER_HUB_TAG`: `1.0.0-SNAPSHOT`
- `IMAGE_NAME_SUFFIX_PROJECT_STUBS`: Final image name
- `IMAGE_VERSION`: `1.0.0`
