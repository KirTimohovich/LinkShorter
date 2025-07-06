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
chmod -R 775 /var/www/database
chmod 755 /var/www

# Генерация APP_KEY, если не задан
if ! grep -q '^APP_KEY=' .env || grep -q '^APP_KEY=$' .env; then
    php artisan key:generate
fi

# Создание базы данных SQLite, если не существует
DB_PATH="/var/www/identifier.sqlite"
if [ ! -f "$DB_PATH" ]; then
    touch "$DB_PATH"
    chown www-data:www-data "$DB_PATH"
    chmod 664 "$DB_PATH"
    echo "Created SQLite database at $DB_PATH"
fi

# Автоматический запуск миграций
php artisan migrate --force || true

# Проверяем и собираем фронтенд, если нужно
if [ ! -f public/build/manifest.json ]; then
    echo "Frontend assets not found. Installing npm dependencies and building..."
    npm install
    npm run build
    echo "Frontend assets built successfully!"
fi

# Запускаем основной процесс (php-fpm)
exec php-fpm 