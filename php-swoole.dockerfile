FROM phpswoole/swoole:5.1-php8.3

RUN docker-php-ext-install pcntl

WORKDIR /app/laravel-example

ENTRYPOINT ["php", "artisan", "octane:start", "--server=swoole", "--port=9804", "--host=0.0.0.0"]
