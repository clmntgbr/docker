ARG PHP_VERSION=8.1.3

FROM php:${PHP_VERSION}-fpm-alpine as symfony_php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add bash
RUN apk add git
RUN apk add nodejs
RUN apk add npm
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

WORKDIR /srv/app/

COPY ["composer.json", "composer.lock", "./"]

RUN     mkdir -p var/cache var/log; \
    composer install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction; \
    composer dump-autoload --classmap-authoritative --no-dev; \
    composer symfony:dump-env prod; \
    composer run-script --no-dev post-install-cmd; \
    composer install; \
    chmod +x bin/console; sync

RUN docker-php-ext-install pdo_mysql
RUN apk add --no-cache zip libzip-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif

RUN set -xe \
    && apk add --update \
    icu \
    && apk add --no-cache --virtual .php-deps \
    make \
    && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    zlib-dev \
    icu-dev \
    g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
    intl \
    && docker-php-ext-enable intl \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*;


ENV EXT_AMQP_VERSION=latest

RUN docker-php-source extract \
    && apk -Uu add git rabbitmq-c-dev \
    && git clone --branch $EXT_AMQP_VERSION --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
    && cd /usr/src/php/ext/amqp && git submodule update --init \
    && docker-php-ext-install amqp

RUN ls -al /usr/local/lib/php/extensions/

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN find /tmp -type d -exec chmod -v 1777 {} +

# RUN chown -R www-data:www-data /srv/app
# USER www-data

COPY assets assets

COPY bin bin
COPY templates templates
COPY translations translations
COPY public public
COPY config config
COPY migrations migrations
COPY src src

CMD chmod -R 777 public/images

ENTRYPOINT ["php-fpm"]
