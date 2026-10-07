#!/bin/sh
PORT="${PORT:-10000}"
sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/:80>/:${PORT}>/" /etc/apache2/sites-available/000-default.conf

touch database/database.sqlite
chown -R www-data:www-data database storage bootstrap/cache
php artisan migrate --force
exec apache2-foreground
