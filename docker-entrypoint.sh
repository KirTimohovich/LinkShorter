#!/bin/sh

# Ждем готовности базы данных
echo "Waiting for database..."
while ! nc -z db 3306; do
    sleep 1
done
echo "Database is ready!"

# Проверяем наличие .env файла
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
fi

# Генерируем ключ приложения если его нет
if ! grep -q "APP_KEY=base64:" .env; then
    echo "Generating application key..."
    php artisan key:generate --no-interaction
fi

# Выполняем миграции
echo "Running migrations..."
php artisan migrate --force

# Очищаем кэш
echo "Clearing cache..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# Оптимизируем для production
if [ "$APP_ENV" = "production" ]; then
    echo "Optimizing for production..."
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
fi

# Запускаем команду
exec "$@" 