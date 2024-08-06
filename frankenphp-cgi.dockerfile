FROM dunglas/frankenphp-dev:builder-php8.3-bookworm

#ENV SERVER_NAME=localhost:80

WORKDIR /app/laravel-example

COPY . /app