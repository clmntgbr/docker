# Symfony Docker Template

A Symfony 6 docker template base project using PHP8, Nginx, MariaDb, RabbitMQ, MailDev.

## Getting Started

1. Clone this repo
2. Edit the .env file to change PROJECT_NAME variable for renaming containers & directory 
3. Run `docker-compose build --pull --no-cache` to build fresh images
4. Run `docker-compose up` (the logs will be displayed in the current shell) or `docker-compose up -d`
5. Enter in the php container with `docker-compose exec php sh`
6. Run `composer install`
7. Open `https://traefik.docker.localhost/dashboard/#/` in your favorite web browser for traefik dashboard
8. Open `https://docker-maildev.docker.localhost` in your favorite web browser for maildev
9. Open `https://docker-rabbitmq.docker.localhost` in your favorite web browser for rabbitmq
10. Open `https://docker.docker.localhost` in your favorite web browser for symfony app
11. Run `docker-compose down --remove-orphans` to stop the Docker containers.

## Features

* PHP 8.1.3
* Nginx 1.20
* RabbitMQ 3-management
* MariaDB 10.4.19
* MailDev
* Traefik latest
* Symfony 6.0.5 with some bundles : `symfony/maker-bundle`, `symfony/web-profiler-bundle`, `symfony/messenger`, etc

**Enjoy!**