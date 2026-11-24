#!/bin/sh

set -eu

if [ -z "${ROOT_DIR:-}" ]; then
    exit 67
fi

DIST_DIR="$ROOT_DIR/dist"

GIT_URL="https://github.com/zyrouge/paseo-custom-container-image.git"
IMAGE_NAME="ghcr.io/zyrouge/paseo-custom"
LOCAL_IMAGE_NAME="localhost/paseo-custom"

PASEO_IMAGE_NAME="ghcr.io/getpaseo/paseo"
PASEO_IMAGE_TAG="latest"
