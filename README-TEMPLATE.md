Weekly updated Gemini CLI Docker image
======================================

[![build](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/tgagor/docker-gemini-cli/actions/workflows/build.yml)
![GitHub](https://img.shields.io/github/license/tgagor/docker-gemini-cli)
![Docker Stars](https://img.shields.io/docker/stars/tgagor/gemini-cli)
![Docker Pulls](https://img.shields.io/docker/pulls/tgagor/gemini-cli)
![GitHub Release Date](https://img.shields.io/github/release-date/tgagor/docker-gemini-cli)

I wanted to have a convenient way to run Gemini CLI without the need to trash my OS with Node and it's dependencies. Easiest way was to wrap it as a Docker image.

## Supported tags and respective Dockerfile links

* [latest](https://github.com/tgagor/docker-gemini-cli/blob/master/Dockerfile) - latest and greatest (default),
* [build-{{ .DOCKER_TAG }}](https://github.com/tgagor/docker-gemini-cli/blob/master/Dockerfile) - represents lates build version, which might contain updates to OS, but not necessarily the Gemini CLI version,
* [v{{ .GEMINI_CLI_VERSION }}, v{{ .GEMINI_CLI_VERSION | splitList "." | first }}, v{{ .GEMINI_CLI_VERSION | splitList "." | rest | first }}](https://github.com/tgagor/docker-gemini-cli/blob/master/Dockerfile) - refers to Gemini CLI version, for convenience.

Version numbers use [SemVer](https://semver.org) and they reflect changes done in this repo - they are NOT related to Gemini CLI versioning. For example, each weekly build will rise version number on last place, meaning patch level update.

## Image sizes
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/docker-gemini-cli/latest?label=gemini-cli%3Alatest%20size)

## Security
My mages are automatically scanned for security issues, actual results are available here: https://github.com/tgagor/docker-gemini-cli/security/advisories

## Images
You can fetch docker image from:
* [tgagor/docker-gemini-cli](https://hub.docker.com/r/tgagor/docker-gemini-cli)
