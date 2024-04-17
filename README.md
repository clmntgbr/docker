# Symfony Docker Template

A Symfony 7 docker template base project using PHP8.3, Nginx, MariaDb, RabbitMQ, MailDev.

## Getting Started

1. Clone this repo
2. Run `cp .env.dist .env`
3. Edit the .env file to change PROJECT_NAME variable for renaming containers & directory
4. Edit Makefile and replace PROJECT_NAME variable same as in the .env file
5. Run `make start` to run containers
6. Run `make init` to initialize the project
7. You can run `make help` to see all commands available

## Overview

Open `http://localhost:8000` for the Symfony app

Open `http://localhost:8003` for the RabbitMQ app

Open `http://localhost:8004` for the MailDev app

## Features

* PHP 8.3.2
* Nginx 1.20
* RabbitMQ 3
* MariaDB 10.4.19
* MailDev
* Symfony 7

**Enjoy!**
