#!/bin/sh

set -eu

UID=${DEFAULT_UID:-1000}
GID=${DEFAULT_GID:-1000}
USER=${DEFAULT_USERNAME:-gemini}
HOME=${DEFAULT_HOME_DIR:-/home/$USER}

if [ "$DEBUG" == "true" ]; then
    echo "Creating unprivileged user matching system user..."
    echo "  Name:     $USER"
    echo "  UID:      $UID"
    echo "  GID:      $GID"
    echo "  Home dir: $HOME"
fi

# create group if it doesn't exist
getent group $GID 2>&1 > /dev/null || addgroup -g $GID $USER

# create user if it doesn't exist
getent passwd $UID 2>&1 > /dev/null || adduser -D -h "$HOME" -u $UID -G $USER $USER

exec su-exec "${UID}:${GID}" "$@"
