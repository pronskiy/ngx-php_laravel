FROM phpswoole/swoole:5.1-php8.3

RUN docker-php-ext-install pcntl

WORKDIR /app/laravel-example

COPY . /app
RUN chown -R www-data:www-data /app
RUN php artisan optimize:clear
RUN php artisan optimize

ENTRYPOINT ["php", "artisan", "octane:start", "--server=swoole", "--port=9804", "--host=0.0.0.0"]
