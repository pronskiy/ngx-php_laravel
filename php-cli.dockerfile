FROM php:8.3-cli

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT ["php", "-c", "/app/deploy/conf/php.ini", "artisan", "serve", "--port=9802", "--host=0.0.0.0"]
