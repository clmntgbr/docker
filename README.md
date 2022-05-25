# Symfony Docker Template

A Symfony 6 docker template base project using PHP8, Nginx, MariaDb, RabbitMQ, MailDev.

## Getting Started

1. Clone https://github.com/clmntgbr/setup and run `make start`
2. Clone this repo
3. Run `cp .env.dist .env`
4. Edit the .env file to change PROJECT_NAME variable for renaming containers & directory
5. Run `make init` to initialize the project
6. You can run `make help` to see all commands available

## Overview

Open `https://docker.localhost/dashboard/#/` in your favorite web browser for traefik dashboard

Open `https://maildev.docker.localhost` in your favorite web browser for maildev

Open `https://rabbitmq.docker.localhost` in your favorite web browser for rabbitmq

Open `https://{docker}.docker.localhost` in your favorite web browser for symfony app

## Features

* PHP 8.1.3
* Nginx 1.20
* RabbitMQ 3-management
* MariaDB 10.4.19
* MailDev
* Traefik latest
* Symfony 6.0.5 with some bundles : `symfony/maker-bundle`, `symfony/web-profiler-bundle`, `symfony/messenger`, etc

**Enjoy!**
