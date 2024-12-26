ARG PHP_VERSION=8.3.2

FROM php:${PHP_VERSION}-fpm-alpine as symfony_php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add --no-cache bash git nodejs npm

RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

WORKDIR /srv/app/

RUN adduser -u 1002 -D appuser
RUN chown -R 1002:1002 /srv/app

COPY ["composer.json", "composer.lock", "./"]

RUN mkdir -p var/cache var/log; \
    composer install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction; \
    composer dump-autoload --classmap-authoritative --no-dev; \
    composer symfony:dump-env prod; \
    composer run-script --no-dev post-install-cmd; \
    composer install; \
    chmod +x bin/console; sync

# Installer pdo_mysql
RUN docker-php-ext-install pdo_mysql

# Installer zip et ses dépendances
RUN apk add --no-cache zip libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# Installer exif
RUN docker-php-ext-configure exif \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

# Installer intl et ses dépendances
RUN set -xe \
    && apk add --no-cache icu \
    && apk add --no-cache --virtual .php-deps make \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS zlib-dev icu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*;

# Installer pdo_pgsql
RUN apk add --no-cache postgresql-dev \
    && docker-php-ext-install pdo_pgsql

# Installer AMQP
ENV EXT_AMQP_VERSION=latest
RUN docker-php-source extract \
    && apk -Uu add git rabbitmq-c-dev \
    && git clone --branch $EXT_AMQP_VERSION --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
    && cd /usr/src/php/ext/amqp && git submodule update --init \
    && docker-php-ext-install amqp

RUN ls -al /usr/local/lib/php/extensions/

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/tmp

RUN chown -R 1002:1002 /srv/app

COPY --from=composer /usr/bin/composer /usr/bin/composer

USER 1002

COPY --chown=1002:1002 . .

RUN chmod 777 /srv/app/public/*

ENTRYPOINT ["php-fpm"]
