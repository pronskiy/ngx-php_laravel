FROM unit:1.32.1-php8.3

ENV WEB_DOCUMENT_ROOT=/var/www/app/public
ENV WEB_DOCUMENT_INDEX=index.php
ENV PHP_OPENSSL=yes

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*.list

# The following extensions are installed by the base php image: sodium ctype curl
RUN docker-php-ext-enable opcache && docker-php-ext-install zip

ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:2.7.7 /usr/bin/composer /usr/local/bin/composer

COPY deploy/unit/* /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/framework-cache.sh

WORKDIR /var/www/app

COPY --chown=unit laravel-example/composer.json laravel-example/composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader

COPY --chown=unit laravel-example .
RUN composer dump-autoload -o -a

EXPOSE 8080
