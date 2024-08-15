#!/bin/sh
   set -e

   # Ensure the socket directory has correct permissions
   mkdir -p /var/run
   chown -R www-data:www-data /var/run
   chmod 755 /var/run

   # Start PHP-FPM
   php-fpm --fpm-config /app/deploy/conf/php-fpm.conf -c /app/deploy/conf/php.ini

   # Start Nginx
   nginx -c /app/deploy/nginx-fpm.conf
   
   tail -f /dev/null
