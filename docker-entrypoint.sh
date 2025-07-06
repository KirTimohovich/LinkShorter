#!/bin/sh
set -e

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

# Генерация APP_KEY, если не задан
if ! grep -q '^APP_KEY=' .env || grep -q '^APP_KEY=$' .env; then
    php artisan key:generate
fi

# Создание базы данных SQLite, если не существует
if [ "$DB_CONNECTION" = "sqlite" ]; then
    DB_PATH=$(grep DB_DATABASE .env | cut -d '=' -f2)
    if [ -z "$DB_PATH" ]; then
        DB_PATH="/var/www/database/database.sqlite"
    fi
    if [ ! -f "$DB_PATH" ]; then
        mkdir -p $(dirname "$DB_PATH")
        touch "$DB_PATH"
        chown www-data:www-data "$DB_PATH"
        chmod 664 "$DB_PATH"
    fi
fi

# Автоматический запуск миграций
php artisan migrate --force || true

# Запускаем основной процесс (php-fpm)
exec php-fpm 