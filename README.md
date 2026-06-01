# Gemini CLI in Docker

A convenient and isolated way to run the [Gemini CLI](https://github.com/google-gemini/gemini-cli) without needing to install Node.js or its dependencies on your local system. This repository provides automatically updated Docker images.

[![build](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml)
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
- To use the Bun variant, simply use `bun` tag: `tgagor/gemini-cli:bun`

#### Platform-specific Notes

**Linux:**
- Works out of the box with the setup above
- File permissions are handled automatically through UID/GID mapping

**macOS:**
- The setup works the same way
- File permissions might behave differently due to how Docker Desktop handles mounting on macOS
- If you experience permission issues, you may need to add `:delegated` to volume mounts for better performance

#### Runtime Variants

This repository provides two runtime variants:

- **Node.js** (default): Available on `linux/amd64`, `linux/arm64`, and `linux/arm/v7`. Use standard tags like `latest`, `v0.44.1`.
- **Bun**: Faster alternative available on `linux/amd64` and `linux/arm64` only. Use tags with `bun` suffix (e.g., `bun`, `v0.44.1-bun`).

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

The following tags are available on [Docker Hub](https://hub.docker.com/r/tgagor/gemini-cli):

### Node.js (Default)

*   [`latest`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Most recent stable version.
*   [`alpine`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest with Alpine Linux base.
*   [`v0.44.1`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Specific version.
*   [`v0.44.1-alpine`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Specific version with Alpine base.
*   [`v0.44`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest patch for a minor version.
*   [`v0.44-alpine`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest patch with Alpine base.
*   [`v0`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest minor release for a major version.
*   [`v0-alpine`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest minor with Alpine base.

### Bun (⚠️ amd64 and arm64 only)

*   [`bun`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest with Bun runtime.
*   [`v0.44.1-bun`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Specific version with Bun.
*   [`v0.44-bun`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest patch for a minor version with Bun.
*   [`v0-bun`](https://hub.docker.com/r/tgagor/gemini-cli/tags): Latest minor with Bun.

## Security

Images are automatically scanned for vulnerabilities. You can view the latest security report [here](https://github.com/tgagor/docker-gemini-cli/security/advisories).

## Image sizes
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=amd64&label=tgagor%2Fgemini-cli%20(amd64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=arm64&label=tgagor%2Fgemini-cli%20(arm64))
![Docker Image Size](https://img.shields.io/docker/image-size/tgagor/gemini-cli?arch=arm&label=tgagor%2Fgemini-cli%20(arm))

## Images
You can fetch docker image from:
* [tgagor/gemini-cli](https://hub.docker.com/r/tgagor/gemini-cli)
