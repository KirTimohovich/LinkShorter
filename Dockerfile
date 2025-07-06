# PHP application
FROM php:8.2-fpm-alpine

# Устанавливаем Node.js и npm
RUN apk add --no-cache nodejs npm

# Устанавливаем системные зависимости
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    sqlite \
    sqlite-dev \
    && docker-php-ext-install \
    pdo_sqlite \
    mbstring \
    bcmath \
    gd

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Устанавливаем рабочую директорию
WORKDIR /var/www

# Копируем composer файлы
COPY composer.json composer.lock ./

# Устанавливаем PHP зависимости
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction

# Копируем исходный код
COPY . .

# Создаем необходимые директории и устанавливаем права доступа
RUN mkdir -p storage/framework/{sessions,views,cache} \
    && mkdir -p storage/logs \
    && mkdir -p bootstrap/cache \
    && mkdir -p database \
    && chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache \
    && chmod -R 775 /var/www/database \
    && chmod 775 /var/www/storage/logs \
    && touch /var/www/identifier.sqlite \
    && chown www-data:www-data /var/www/identifier.sqlite \
    && chmod 664 /var/www/identifier.sqlite

# Создаем entrypoint скрипт
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
