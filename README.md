# Gemini CLI in Docker

A convenient and isolated way to run the [Gemini CLI](https://github.com/google-gemini/gemini-cli) without needing to install Node.js or its dependencies on your local system. This repository provides automatically updated Docker images.

[![build](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml)
![GitHub](https://img.shields.io/github/license/tgagor/docker-gemini-cli)
![Docker Stars](https://img.shields.io/docker/stars/tgagor/gemini-cli)
![Docker Pulls](https://img.shields.io/docker/pulls/tgagor/gemini-cli)
![GitHub Release Date](https://img.shields.io/github/release-date/tgagor/docker-gemini-cli)


## Prerequisites

* [Docker](https://docs.docker.com/get-docker/) must be installed and running on your system.

## Usage

### Recommended Setup

The recommended way to use this image is to create a shell function that handles all the necessary mount points and permissions. Add the following function to your `~/.bash_aliases` or `~/.zsh_aliases`:

```bash
function gemini {
    local tty_args=""
    if [ -t 0 ]; then
        tty_args="--tty"
    fi

    docker run -i ${tty_args} --rm \
        -v "$(pwd):/home/gemini/workspace" \
        -v "$HOME/.gemini:/home/gemini/.gemini" \
        -e DEFAULT_UID=$(id -u) \
        -e DEFAULT_GID=$(id -g) \
        tgagor/gemini-cli "$@"
}
```

This setup:
- Mounts your current directory as `/home/gemini/workspace` inside the container
- Mounts `~/.gemini` to preserve Gemini CLI configuration between runs
- Matches container user permissions with your local user to avoid file ownership issues
- Handles TTY properly for interactive use

#### Platform-specific Notes

**Linux:**
- Works out of the box with the setup above
- File permissions are handled automatically through UID/GID mapping

**macOS:**
- The setup works the same way
- File permissions might behave differently due to how Docker Desktop handles mounting on macOS
- If you experience permission issues, you may need to add `:delegated` to volume mounts for better performance

### Basic Docker Usage

While not recommended, you can still run the container directly with Docker commands:

```bash
docker run --rm -it \
    -v "$(pwd):/home/gemini/workspace" \
    -v "$HOME/.gemini:/home/gemini/.gemini" \
    -e DEFAULT_UID=$(id -u) \
    -e DEFAULT_GID=$(id -g) \
    tgagor/gemini-cli [command]
```

### Examples

**Using the shell function (recommended):**
```bash
# Get help
gemini --help

# Process a local file
gemini your-prompt-file.txt

# Pipe file as context
cat doc.md | gemini -p "Correct grammar"

# Use interactive mode
gemini
```

## Supported Tags

The following tags are available on [Docker Hub](https://hub.docker.com/r/tgagor/docker-gemini-cli):

*   [`latest`](https://hub.docker.com/repository/docker/tgagor/gemini-cli/tags): The most recent, stable version of the Gemini CLI.
*   [`v0.11.2`](https://hub.docker.com/repository/docker/tgagor/gemini-cli/tags) (e.g., `v0.11.0`): Corresponds to a specific version of the Gemini CLI.
*   [`v0.11`](https://hub.docker.com/repository/docker/tgagor/gemini-cli/tags) (e.g., `v0.11`): Points to the latest patch release for a minor version.
*   [`v0`](https://hub.docker.com/repository/docker/tgagor/gemini-cli/tags) (e.g., `v0`): Points to the latest minor release for a major version.

## Security

Images are automatically scanned for vulnerabilities. You can view the latest security report [here](https://github.com/tgagor/docker-gemini-cli/security/advisories).

## Image sizes
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=amd64&label=tgagor%2Fgemini-cli%20(amd64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=arm64&label=tgagor%2Fgemini-cli%20(arm64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=arm&label=tgagor%2Fgemini-cli%20(arm))




## Images
You can fetch docker image from:
* [tgagor/gemini-cli](https://hub.docker.com/r/tgagor/gemini-cli)
