#!/bin/bash

printf "Building the image ... "
docker build -q -t laravel-fpm-nginx -f ./php-fpm.dockerfile .

printf "\nLaravel default, no opcache\nRunning ... "
docker run --name laravel-fpm-default -d --entrypoint /app/fpm-entrypoints/php-fpm-default.sh -p 9803:9803 laravel-fpm-nginx
sleep 1
ab -n 500 -c 5 http://localhost:9803/ 2>&1 | grep "Requests per second"
docker rm -f laravel-fpm-default > /dev/null

printf "\nWith opcache and JIT \nRunning ... "
docker run --name laravel-fpm-opcache -d --entrypoint /app/fpm-entrypoints/php-fpm-opcache.sh -p 9803:9803 laravel-fpm-nginx
sleep 1
ab -n 500 -c 5 http://localhost:9803/ 2>&1 | grep "Requests per second"

printf "\nLaravel without sessions, with opcache \nRunning ... "
ab -n 500 -c 5 http://localhost:9803/nosession 2>&1 | grep "Requests per second"
docker rm -f laravel-fpm-opcache > /dev/null

