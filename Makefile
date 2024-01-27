#!/usr/bin/env bash

PROJECT_NAME = back

DOCKER_COMPOSE = docker-compose -p $(PROJECT_NAME)

CONTAINER_NGINX = $$(docker container ls -f "name=$(PROJECT_NAME)_nginx" -q)
CONTAINER_PHP = $$(docker container ls -f "name=$(PROJECT_NAME)_php" -q)
CONTAINER_DB = $$(docker container ls -f "name=$(PROJECT_NAME)_database" -q)

NGINX = docker exec -ti $(CONTAINER_NGINX)
PHP = docker exec -ti $(CONTAINER_PHP)
DATABASE = docker exec -ti $(CONTAINER_DB)

COLOR_RESET			= \033[0m
COLOR_ERROR			= \033[31m
COLOR_INFO			= \033[32m
COLOR_COMMENT		= \033[33m
COLOR_TITLE_BLOCK	= \033[0;44m\033[37m

help:
	@printf "${COLOR_TITLE_BLOCK}Makefile${COLOR_RESET}\n"
	@printf "\n"
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make [target]\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9\@]+:/ { \
		helpLine = match(lastLine, /^## (.*)/); \
		helpCommand = substr($$1, 0, index($$1, ":")); \
		helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
		printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Kill all containers
kill:
	@$(DOCKER_COMPOSE) kill $(CONTAINER) || true

## Build containers
build:
	@$(DOCKER_COMPOSE) build --pull --no-cache

## Init project
init: install update

## Start containers
start:
	@$(DOCKER_COMPOSE) up -d
	@echo "admin is available here: 'https://back.traefik.me'"

## Stop containers
stop:
	@$(DOCKER_COMPOSE) down

restart: stop start

## Init project
init: install update


cache:
	$(PHP) rm -r var/cache

## Entering php shell
php:
	@$(DOCKER_COMPOSE) exec php sh

## Entering nginx shell
nginx:
	@$(DOCKER_COMPOSE) exec nginx sh

## Entering database shell
database:
	@$(DOCKER_COMPOSE) exec database sh

## Composer install
install:
	$(PHP) composer install

## Composer update
update:
	$(PHP) composer update

## QA
cs-fixer:
	docker run --init -it --rm -v $(PWD):/project -w /project jakzal/phpqa php-cs-fixer fix ./src --rules=@Symfony

cs-fixer-dry:
	docker run --init -it --rm -v $(PWD):/project -w /project jakzal/phpqa php-cs-fixer fix ./src --rules=@Symfony --dry-run

phpcpd:
	docker run --init -it --rm -v $(PWD):/project -w /project jakzal/phpqa phpcpd ./src

phpstan:
	docker run --init -it --rm -v $(PWD):/project -w /project jakzal/phpqa phpstan analyse ./src --level=5