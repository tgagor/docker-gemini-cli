#!/bin/bash

set -eu

USER_ID=${DEFAULT_UID:-1000}
GROUP_ID=${DEFAULT_GID:-1000}
USER=${DEFAULT_USERNAME:-gemini}
HOME=${DEFAULT_HOME_DIR:-/home/$USER}

if [ "$DEBUG" == "true" ]; then
    echo "Creating unprivileged user matching system user..."
    echo "  Name:     $USER"
    echo "  UID:      $USER_ID"
    echo "  GID:      $GROUP_ID"
    echo "  Home dir: $HOME"
fi

# create group if it doesn't exist
getent group $GROUP_ID 2>&1 > /dev/null || addgroup -g $GROUP_ID $USER

# create user if it doesn't exist
# assign to existing group at GID if available, otherwise use $USER as group name
getent passwd $USER_ID 2>&1 > /dev/null || {
    GROUP_NAME=$(getent group "$GROUP_ID" | cut -d: -f1) || GROUP_NAME="$USER"
    adduser -D -h "$HOME" -u $USER_ID -G "$GROUP_NAME" -s /bin/bash $USER
}

exec su-exec "${USER_ID}:${GROUP_ID}" "$@"
