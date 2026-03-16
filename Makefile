SHELL=/bin/bash
BUILD_CONFIG ?= build.yaml
DOCKER_REGISTRY ?= $(shell cat $(BUILD_CONFIG)| yq -r .prefix)
GIT_COMMIT ?= $(shell git rev-parse HEAD)
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_URL ?= $(shell git config --get remote.origin.url)
GIT_TAG ?= $(shell echo $(GIT_BRANCH) | sed -E 's/[/:]/-/g' | sed 's/main/latest/' )
DOCKER_CMD ?= docker
MAINTAINER ?= $(shell cat build.yaml| yq -r '.maintainer')
IMAGES := $(shell cat build.yaml| yq -r '.images|keys[]')

# use numer of available CPUs to run multiple builds at the same time
PARALLEL := $(shell $(DOCKER_CMD) info --format "{{ .NCPU }}")

.PHONY: all build push summary clean

all: build summary

build:
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--build \
		--engine buildx \
		--verbose \
		--tag $(GIT_TAG)

$(IMAGES):
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--image $@ \
		--build \
		--engine buildx \
		--tag $(GIT_TAG)

push:
	td --config $(BUILD_CONFIG) \
		--push \
		--tag $(GIT_TAG)

build-and-push:
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--build \
		--engine buildx \
		--push \
		--tag $(GIT_TAG)

define stage_status
	@echo
	@echo
	@echo ================================================================================
	@echo Building: $(1)
	@echo ================================================================================
endef

define summary
	@echo
	@echo
	@echo ================================================================================
	@echo Generated images:
	@echo ================================================================================
	@$(DOCKER_CMD) image ls \
		--format "{{.Repository}}:{{.Tag}}\t{{.Size}}" \
		--filter=dangling=false \
		--filter=reference="$(DOCKER_REGISTRY)/*:*" | sort | column -t
endef


clean:
	@$(DOCKER_CMD) image rm -f $(shell $(DOCKER_CMD) image ls --format "{{.Repository}}:{{.Tag}}" --filter=dangling=false --filter=reference="$(DOCKER_REGISTRY)/*:*") 2>/dev/null || true

prune:
	@$(DOCKER_CMD) system prune --all --force --volumes
	@$(DOCKER_CMD) buildx prune --all --force

summary:
	$(call summary)
