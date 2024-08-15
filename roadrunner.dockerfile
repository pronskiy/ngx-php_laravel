FROM php:8.3-cli

RUN docker-php-ext-install pcntl sockets

RUN apt-get update && apt-get install git -y

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT ["sh", "/app/roadrunner-entrypoint.sh"]
