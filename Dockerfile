# Dockerfile для Laravel + Vue (Vite)
FROM php:8.2-fpm

# Системные зависимости и расширения PHP
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    npm nodejs \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Установка Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Копируем проект
WORKDIR /var/www
COPY . .

# Установка зависимостей Laravel и Node.js
RUN composer install --no-interaction --prefer-dist --optimize-autoloader
RUN npm install && npm run build

# Права доступа
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
