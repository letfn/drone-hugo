SHELL := /bin/bash

ifeq (shell,$(firstword $(MAKECMDGOALS)))
NAME := $(strip $(wordlist 2,2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))
$(eval $(NAME):;@:)
endif

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile | sort -b

all: # Run everything
	$(MAKE) lint
	$(MAKE) test
	$(MAKE) docs

fmt: # Format drone fmt
	@echo
	drone exec --pipeline $@

lint: # Run drone lint
	@echo
	drone exec --pipeline $@

test: # Run tests
	@echo
	drone exec --pipeline $@

docs: # Build docs with hugo
	@echo
	drone exec --pipeline $@

build: # Build defn/container
	@echo
	drone exec --pipeline $@ --secret-file .drone.secret

shell: # Get a shell
	docker run --rm -ti -v $(PWD):/drone/src --entrypoint bash $(NAME)

pull:
	docker pull defn/container
