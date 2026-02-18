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
# assign to existing group at GID if available, otherwise use $USER as group name
getent passwd $UID 2>&1 > /dev/null || {
    GROUP_NAME=$(getent group "$GID" | cut -d: -f1) || GROUP_NAME="$USER"
    adduser -D -h "$HOME" -u $UID -G "$GROUP_NAME" $USER
}

exec su-exec "${UID}:${GID}" "$@"
