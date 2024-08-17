FROM php:8.3-fpm

RUN apt-get update -y && apt-get install -y nginx

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app/laravel-example/storage /app/laravel-example/database && \
    chmod +x /app/fpm-entrypoints/*
RUN yes| php artisan migrate
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT ["sh", "/app/php-fpm-entrypoint.sh"]

EXPOSE 9803