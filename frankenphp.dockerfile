FROM php:8.3-cli

RUN docker-php-ext-install pcntl

WORKDIR /app/laravel-example

ENTRYPOINT ["sh", "/app/frankenphp-entrypoint.sh"]
