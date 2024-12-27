# Symfony Docker Template

A Symfony 7.2 docker template base project using PHP8.3, Nginx, MariaDb, RabbitMQ.

## Getting Started

1. Clone this repo
2. Run `cp .env.dist .env`
3. Edit the .env file to change PROJECT_NAME variable for renaming containers & directory
4. Run `make start` to run containers
5. Run `make init` to initialize the project

## Overview

Open `http://localhost:9000` for the Symfony app
Open `http://localhost:9003` for the RabbitMQ app

## Features

* PHP 8.3.2
* Nginx 1.20
* RabbitMQ 3
* MariaDB 10.4.19
* Symfony 7.2
* Some bundles like doctrine, messenger and amqp-messenger are pre-installed and configured.

**Enjoy!**
