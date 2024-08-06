FROM php:8.3-cli

RUN docker-php-ext-install pcntl

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app

ENTRYPOINT ["sh", "/app/frankenphp-worker-entrypoint.sh"]
