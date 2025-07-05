#!/bin/bash

echo "🚀 Запуск LinkShorter проекта..."

# Проверяем, есть ли .env файл
if [ ! -f .env ]; then
    echo "📝 Создаем .env файл..."
    if [ -f .env.example ]; then
        cp .env.example .env
    else
        echo "⚠️  Файл .env.example не найден. Создаем базовый .env файл..."
        cat > .env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=shortener
DB_USERNAME=laravel
DB_PASSWORD=secret

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="\${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_APP_NAME="\${APP_NAME}"
VITE_PUSHER_APP_KEY="\${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="\${PUSHER_HOST}"
VITE_PUSHER_PORT="\${PUSHER_PORT}"
VITE_PUSHER_SCHEME="\${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="\${PUSHER_APP_CLUSTER}"
EOF
    fi
fi

echo "🔨 Собираем Docker контейнеры..."
docker-compose build --no-cache

echo "🚀 Запускаем контейнеры..."
docker-compose up -d

echo "⏳ Ждем запуска базы данных..."
sleep 10

echo "🔄 Выполняем миграции..."
docker-compose exec app php artisan migrate --force

echo "✅ Проект запущен!"
echo "🌐 Доступен по адресу: http://localhost:8000"
echo "📊 База данных: localhost:3306"
echo ""
echo "Для остановки используйте: docker-compose down"
echo "Для просмотра логов используйте: docker-compose logs -f" 