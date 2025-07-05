# Dockerfile для Laravel + Vue (Vite)
FROM php:8.2-fpm

# Системные зависимости и расширения PHP
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    npm nodejs \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Установка Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Устанавливаем рабочую директорию
WORKDIR /var/www

# Копируем composer файлы для кэширования слоев
COPY composer.json composer.lock ./

# Устанавливаем зависимости PHP
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

# Копируем остальные файлы проекта
COPY . .

# Создаем .env файл если его нет
RUN if [ ! -f .env ]; then \
        cp .env.example .env 2>/dev/null || \
        echo "APP_NAME=Laravel\nAPP_ENV=local\nAPP_KEY=\nAPP_DEBUG=true\nAPP_URL=http://localhost\n\nLOG_CHANNEL=stack\nLOG_DEPRECATIONS_CHANNEL=null\nLOG_LEVEL=debug\n\nDB_CONNECTION=mysql\nDB_HOST=db\nDB_PORT=3306\nDB_DATABASE=shortener\nDB_USERNAME=laravel\nDB_PASSWORD=secret\n\nBROADCAST_DRIVER=log\nCACHE_DRIVER=file\nFILESYSTEM_DISK=local\nQUEUE_CONNECTION=sync\nSESSION_DRIVER=file\nSESSION_LIFETIME=120\n\nMEMCACHED_HOST=127.0.0.1\n\nREDIS_HOST=127.0.0.1\nREDIS_PASSWORD=null\nREDIS_PORT=6379\n\nMAIL_MAILER=smtp\nMAIL_HOST=mailpit\nMAIL_PORT=1025\nMAIL_USERNAME=null\nMAIL_PASSWORD=null\nMAIL_ENCRYPTION=null\nMAIL_FROM_ADDRESS=\"hello@example.com\"\nMAIL_FROM_NAME=\"\${APP_NAME}\"\n\nAWS_ACCESS_KEY_ID=\nAWS_SECRET_ACCESS_KEY=\nAWS_DEFAULT_REGION=us-east-1\nAWS_BUCKET=\nAWS_USE_PATH_STYLE_ENDPOINT=false\n\nPUSHER_APP_ID=\nPUSHER_APP_KEY=\nPUSHER_APP_SECRET=\nPUSHER_HOST=\nPUSHER_PORT=443\nPUSHER_SCHEME=https\nPUSHER_APP_CLUSTER=mt1\n\nVITE_APP_NAME=\"\${APP_NAME}\"\nVITE_PUSHER_APP_KEY=\"\${PUSHER_APP_KEY}\"\nVITE_PUSHER_HOST=\"\${PUSHER_HOST}\"\nVITE_PUSHER_PORT=\"\${PUSHER_PORT}\"\nVITE_PUSHER_SCHEME=\"\${PUSHER_SCHEME}\"\nVITE_PUSHER_APP_CLUSTER=\"\${PUSHER_APP_CLUSTER}\"" > .env; \
    fi

# Генерируем ключ приложения
RUN php artisan key:generate --no-interaction

# Устанавливаем зависимости Node.js и собираем assets
RUN npm install && npm run build

# Права доступа
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
