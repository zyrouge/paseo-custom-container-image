#!/bin/sh

set -eu

ROOT_DIR="$(dirname "$(realpath "$0")")"

. "$ROOT_DIR/_utils.sh"

mkdir -p "$DIST_DIR"

if [ -z "${PASEO_VERSION:-}" ]; then
    podman pull "$PASEO_IMAGE_NAME:$PASEO_IMAGE_TAG"
    PASEO_VERSION="$(podman run --rm -t "$PASEO_IMAGE_NAME:$PASEO_IMAGE_TAG" paseo --version | tr -d '\r')"
    if [ "$?" -ne 0 ] || [ -z "$PASEO_VERSION" ]; then
        echo "Error: Failed to fetch paseo version"
        exit 1
    fi
fi

echo "Version: $PASEO_VERSION"
echo "$PASEO_VERSION" > "$DIST_DIR/version.txt"

if [ -z "${NEEDS_RELEASE:-}" ]; then
    set +e
    IMAGE_MANIFEST=$(podman manifest inspect "$IMAGE_NAME:$PASEO_VERSION" 2>&1)
    FOUND_VERSION_EXIT_CODE="$?"
    set -e
    if [ "$FOUND_VERSION_EXIT_CODE" -eq 0 ]; then
        NEEDS_RELEASE="false"
    elif [ "$FOUND_VERSION_EXIT_CODE" -eq 125 ]; then
        NEEDS_RELEASE="true"
    else
        echo "Image manifest check: $IMAGE_MANIFEST"
        echo "Error: Failed to fetch image manifest"
        exit 1
    fi
fi

echo "Needs release: $NEEDS_RELEASE"
echo "$NEEDS_RELEASE" > "$DIST_DIR/needs_release.txt"
