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

CONTAINERS ?= builder release runner superset

.PHONY: build push rm push-rm pull
build push rm push-rm pull: is-defined-CONTAINERS
	@for CONTAINER in $(CONTAINERS); do                                     \
	  $(MAKE) -C containers.d/$$CONTAINER "$@";                             \
	done;
