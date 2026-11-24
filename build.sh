#!/bin/sh

set -eu

ROOT_DIR="$(dirname "$(realpath "$0")")"

. "$ROOT_DIR/_utils.sh"

get_release_info_key() {
    if ! [ -f "$DIST_DIR/$1" ]; then
        "$ROOT_DIR/release-info.sh" >&2
    fi
    cat "$DIST_DIR/$1"
}

echo "Fetching version..."
if [ -z "${PASEO_VERSION:-}" ]; then
    PASEO_VERSION="$(get_release_info_key version.txt)"
fi

CREATED=$(date -u +"%Y-%m-%dT%H:%M:%S%z")

echo "Removing old image..."
podman rmi "$LOCAL_IMAGE_NAME:$PASEO_VERSION" > /dev/null 2>&1 || true

echo "Removing old manifest..."
podman manifest rm "$LOCAL_IMAGE_NAME:$PASEO_VERSION" > /dev/null 2>&1 || true

echo "Creating manifest..."
podman manifest create "$LOCAL_IMAGE_NAME:$PASEO_VERSION"

echo "Building image..."
podman build \
    --build-arg CREATED="$CREATED" \
    --build-arg PASEO_IMAGE_NAME="$PASEO_IMAGE_NAME" \
    --build-arg PASEO_IMAGE_TAG="$PASEO_VERSION" \
    --build-arg PASEO_VERSION="$PASEO_VERSION" \
    --platform linux/amd64 \
    --manifest "$LOCAL_IMAGE_NAME:$PASEO_VERSION" \
    "$ROOT_DIR"
echo "Built image $LOCAL_IMAGE_NAME:$PASEO_VERSION"
