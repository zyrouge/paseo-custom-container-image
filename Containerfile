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

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl && \
    mkdir -p -m 755 /etc/apt/keyrings && \
    wget -nv -O /etc/apt/keyrings/githubcli-archive-keyring.gpg https://cli.github.com/packages/githubcli-archive-keyring.gpg && \
    chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
	mkdir -p -m 755 /etc/apt/sources.list.d && \
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
	apt-get update && \
    apt-get install -y --no-install-recommends bash iputils-ping vim dnsutils iproute2 netcat-openbsd file findutils unzip zip tar xz-utils gzip python3 git gh && \
    rm -rf /var/lib/apt/lists/*

RUN npm i -g @opencode/cli@latest

ENV PROTO_HOME=/usr/local/share/proto
ENV PATH="$PROTO_HOME/bin:$PATH"

RUN bash -c "bash <(curl -fsSL https://moonrepo.dev/install/proto.sh) latest --no-profile --yes" && \
    chmod -R a+rwX "$PROTO_HOME"

ENV SHELL=/bin/bash
