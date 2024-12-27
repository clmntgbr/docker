#!/usr/bin/env bash

PROJECT_NAME = docker
DOCKER_COMPOSE = docker compose -p $(PROJECT_NAME)

CONTAINER_NGINX = $$(docker container ls -f "name=$(PROJECT_NAME)-nginx" -q)
CONTAINER_PHP = $$(docker container ls -f "name=$(PROJECT_NAME)-php" -q)
CONTAINER_DB = $$(docker container ls -f "name=$(PROJECT_NAME)-database" -q)

NGINX = docker exec -ti $(CONTAINER_NGINX)
PHP = docker exec -ti $(CONTAINER_PHP)
DATABASE = docker exec -ti $(CONTAINER_DB)

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

## Stop containers
stop:
	@$(DOCKER_COMPOSE) down

restart: stop start

## Init project
init: install update fabric

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

fabric: 
	$(PHP) bin/console messenger:setup-transports