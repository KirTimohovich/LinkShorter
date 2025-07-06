#!/bin/sh

# Копируем .env, если его нет
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
fi

# Устанавливаем права на storage, cache, базу и папку /var/www
echo "Setting proper permissions..."
chown -R www-data:www-data /var/www
chmod -R 775 /var/www/storage
chmod -R 775 /var/www/bootstrap/cache
chmod 664 /var/www/identifier.sqlite
chmod 755 /var/www

# Запускаем основной процесс (php-fpm)
exec "$@" 