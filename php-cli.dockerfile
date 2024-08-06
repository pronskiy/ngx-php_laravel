FROM php:8.3-cli

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app

ENTRYPOINT ["php", "artisan", "serve", "--port=9802", "--host=0.0.0.0"]
