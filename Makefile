SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile | sort -b

all: # Run everything except build
	$(MAKE) fmt
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

docs: # Build docs
	@echo
	drone exec --pipeline $@

build: # Build container
	@echo
	drone exec --pipeline $@ --secret-file .drone.secret
	cat benchmark/build.json | jq -r 'to_entries | map(.value = (.value/1000000/1000 | tostring | split(".")[0] | tonumber))[] | "\(.value) \(.key)"' | sort -n | talign 1
