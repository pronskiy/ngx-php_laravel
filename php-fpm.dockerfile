FROM php:8.3-fpm


RUN apt-get update -y && apt-get install -y nginx

WORKDIR /app/laravel-example

ENTRYPOINT ["sh", "/app/php-fpm-entrypoint.sh"]
