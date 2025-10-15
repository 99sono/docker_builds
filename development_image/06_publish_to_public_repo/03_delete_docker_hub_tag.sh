#!/bin/bash

# Delete a Docker Hub repository tag (both local and optionally remote)
#
# This script can delete local Docker tags and optionally Docker Hub repository tags
# Useful for cleaning up old snapshots before publishing new versions

set -e

# Source environment variables
source ../00_common_env.sh

usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --local           Delete only local tag (default)"
    echo "  --remote          Delete remote tag from Docker Hub (requires login)"
    echo "  --both            Delete both local and remote tags"
    echo "  --tag TAG         Specify custom tag to delete (default: 1.0.0-SNAPSHOT)"
    echo "  --repo REPO       Specify custom repository (default: $DOCKER_HUB_REPO_NAME)"
    echo "  --help            Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 --local              # Delete local 1.0.0-SNAPSHOT tag"
    echo "  $0 --remote             # Delete remote tag (requires docker login)"
    echo "  $0 --both               # Delete both local and remote tags"
    echo "  $0 --tag 1.0.0-alpha    # Delete custom tag locally"
}

# Default values
DELETE_LOCAL=false
DELETE_REMOTE=false
TAG_TO_DELETE="$DOCKER_HUB_TAG"
REPO_TO_DELETE="$DOCKER_HUB_REPO_NAME"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --local)
            DELETE_LOCAL=true
            shift
            ;;
        --remote)
            DELETE_REMOTE=true
            shift
            ;;
        --both)
            DELETE_LOCAL=true
            DELETE_REMOTE=true
            shift
            ;;
        --tag)
            TAG_TO_DELETE="$2"
            shift 2
            ;;
        --repo)
            REPO_TO_DELETE="$2"
            shift 2
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# If no action specified, default to local
if [[ $DELETE_LOCAL == false && $DELETE_REMOTE == false ]]; then
    DELETE_LOCAL=true
fi

echo "🗑️ Deleting Docker tag: ${REPO_TO_DELETE}:${TAG_TO_DELETE}"
echo "================================="

# Delete local tag
if [[ $DELETE_LOCAL == true ]]; then
    echo "Deleting local tag: ${REPO_TO_DELETE}:${TAG_TO_DELETE}"
    if docker images "${REPO_TO_DELETE}:${TAG_TO_DELETE}" | grep -q "${REPO_TO_DELETE}"; then
        docker rmi "${REPO_TO_DELETE}:${TAG_TO_DELETE}"
        echo "✅ Local tag deleted successfully"
    else
        echo "ℹ️ Local tag not found (may have already been deleted)"
    fi
    echo ""
fi

# Delete remote tag (requires docker login)
if [[ $DELETE_REMOTE == true ]]; then
    echo "Deleting remote tag: ${REPO_TO_DELETE}:${TAG_TO_DELETE}"

    # Check if logged in
    if ! docker system info | grep -q "Username:"; then
        echo "❌ ERROR: Docker is not logged in!"
        echo "Please run 'docker login' first to delete remote tags."
        exit 1
    fi

    # Note: Docker CLI doesn't directly delete remote tags
    # We'll push an empty image to effectively replace it
    echo "Note: Docker CLI cannot directly delete remote tags."
    echo "To delete remote tag, you have several options:"
    echo ""
    echo "1. Use Docker Hub web interface:"
    echo "   - Go to https://hub.docker.com/repository/docker/${REPO_TO_DELETE}"
    echo "   - Navigate to tags and delete manually"
    echo ""
    echo "2. Use Docker Hub API (requires personal access token):"
    echo "   curl -X DELETE https://hub.docker.com/v2/repositories/\${DOCKER_USERNAME}/${REPO_TO_DELETE}/tags/${TAG_TO_DELETE}/"
    echo ""
    echo "3. Push new version with same tag to overwrite (recommended for snapshots)"
    echo ""

    echo "❌ Remote tag deletion failed - manual intervention required"
    exit 1
fi
