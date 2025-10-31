FROM alpine:3.22

# set some defaults
ENV DEBUG=false

VOLUME /tmp /var/cache/apk /var/tmp /root/.cache /root/.npm

# FIXME: I'm not sure if it's needed at all
# configure locale
# ENV LANG="en_US.UTF-8"
# ENV LANGUAGE="en_US:en"
# ENV LC_ALL="en_US.UTF-8"
# configure timezone
# ARG TIMEZONE="UTC"
# RUN apk add --no-cache tzdata && \
#     cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
#     echo "$TIMEZONE" > /etc/timezone && \
#     apk del tzdata && \
#     date

# Setup unprivileged user defaults
COPY usr/ /usr/
RUN apk add --no-cache su-exec && \
    chmod +x /usr/local/sbin/docker-entrypoint.sh

# Install Gemini CLI
ARG GEMINI_CLI_VERSION="latest"
ARG TARGETPLATFORM
RUN apk add --no-cache nodejs npm && \

    if [ "$TARGETPLATFORM" != "linux/amd64" ]; then \
        apk add --no-cache python3 py3-pip build-base git; \
    fi && \
    npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION} && \
    rm -rf ~/.npm && \
    apk del --no-cache npm && \
    if [ "$TARGETPLATFORM" != "linux/amd64" ]; then \
        apk del --no-cache python3 py3-pip build-base git; \
    fi && \
    gemini --version

WORKDIR /home/gemini/workspace
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh", "gemini"]
