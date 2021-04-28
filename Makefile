#!/usr/bin/make
docker_compose_bin = docker-compose

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

.PHONY : help init start stop
.DEFAULT_GOAL := help

help: ## Show help text
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

---------------: ## Development tasks ---------------

init: start ## Initialize project
	@echo "********************************************************************\n\
	* This project was successfully initialized. Let's go to coding :) *\n\
	********************************************************************\n"

start: ## Run project in background
	${docker_compose_bin} up --build -d

stop: ## Stop project
	${docker_compose_bin} stop

logs:
	@./task logs