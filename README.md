# Symfony Docker Template

A Symfony 6 docker template base project using PHP8, Nginx, MariaDb, RabbitMQ, MailDev.

## Getting Started

1. Clone this repo
2. Run `cp .env.dist .env`
3. Edit the .env file to change PROJECT_NAME variable for renaming containers & directory
4. Run `make init` to initialize the project
5. You can run `make help` to see all commands available

## Overview

Open `https://traefik.docker.localhost/dashboard/#/` in your favorite web browser for traefik dashboard

Open `https://{docker}-maildev.docker.localhost` in your favorite web browser for maildev

Open `https://{docker}-rabbitmq.docker.localhost` in your favorite web browser for rabbitmq

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
