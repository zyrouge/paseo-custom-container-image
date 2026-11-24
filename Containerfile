ARG PASEO_IMAGE_NAME=ghcr.io/getpaseo/paseo
ARG PASEO_IMAGE_TAG=latest

FROM $PASEO_IMAGE_NAME:$PASEO_IMAGE_TAG

ARG IMAGE_NAME=paseo-custom-container-image
ARG MAINTAINER=hello@zyrouge.me
ARG CREATED=01-01-01T00:00:00Z
ARG PASEO_VERSION=0.0.0

LABEL maintainer="$MAINTAINER"
LABEL org.opencontainers.image.name="$IMAGE_NAME"
LABEL org.opencontainers.image.created="$CREATED"
LABEL org.opencontainers.image.version="$PASEO_VERSION"

RUN npm i -g @opencode/cli@latest
