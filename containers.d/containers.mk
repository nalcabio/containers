# -*- coding: utf-8; mode: makefile-gmake; -*-

MAKEFLAGS += --no-print-directory --warn-undefined-variables

SHELL := bash
.SHELLFLAGS := -euo pipefail -c

HERE := $(shell cd -P -- $(shell dirname -- $$0) && pwd -P)

.PHONY: all
all: build

.PHONY: has-command-%
has-command-%:
	@$(if $(shell command -v $* 2> /dev/null),,$(error The command $* does not exist in PATH))

.PHONY: is-defined-%
is-defined-%:
	@$(if $(value $*),,$(error The environment variable $* is undefined))

REGISTRY := ghcr.io

.PHONY: login
login: is-defined-GITHUB_USERNAME is-defined-GITHUB_PASSWORD is-defined-REGISTRY has-command-podman
	@echo "$(GITHUB_PASSWORD)" | podman login -u $(GITHUB_USERNAME) --password-stdin $(REGISTRY)

.PHONY: build
build: is-defined-REGISTRY is-defined-CONTAINER is-defined-VERSION login
	@podman build --pull -f Containerfile -t $(REGISTRY)/$(CONTAINER):$(VERSION) .

.PHONY: push
push: build
	@podman push $(REGISTRY)/$(CONTAINER):$(VERSION)

.PHONY: rm
rm: is-defined-REGISTRY is-defined-CONTAINER is-defined-VERSION has-command-podman
	@podman image rm $(REGISTRY)/$(CONTAINER):$(VERSION)

.PHONY: push-rm
push-rm: push rm

.PHONY: pull
pull: login
	@podman pull $(REGISTRY)/$(CONTAINER):$(VERSION)
