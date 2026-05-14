ARG BASE_IMAGE=alpine:3.23
FROM ${BASE_IMAGE}

# set some defaults
ENV DEBUG=false

VOLUME /tmp /var/cache/apk /var/tmp /root/.cache /root/.npm

# Setup unprivileged user defaults
COPY usr/ /usr/
RUN apk add --no-cache su-exec && \
    chmod +x /usr/local/sbin/docker-entrypoint.sh

# Install Gemini CLI
ARG GEMINI_CLI_VERSION="latest"
ARG TARGETPLATFORM
RUN apk add --no-cache \
    bash \
    coreutils \
    libsecret && \
    # Add build dependencies for ARM platforms to compile native modules
    if [ "$TARGETPLATFORM" != "linux/amd64" ]; then \
    apk add --no-cache python3 py3-pip build-base git; \
    fi && \
    # Install Gemini CLI
    bun install -g @google/gemini-cli@${GEMINI_CLI_VERSION}; \
    rm -rf ~/.npm && \
    # Cleanup build dependencies for ARM platforms
    if [ "$TARGETPLATFORM" != "linux/amd64" ]; then \
    apk del --no-cache python3 py3-pip build-base git; \
    fi && \
    gemini --version

WORKDIR /home/gemini/workspace
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh", "gemini"]
