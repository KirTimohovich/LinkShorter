# Основной образ для PHP с Alpine Linux
FROM php:8.2-fpm-alpine

# Устанавливаем системные зависимости
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    mysql-client \
    nodejs \
    npm \
    && docker-php-ext-install \
    pdo_mysql \
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

# Копируем package.json и package-lock.json
COPY package.json package-lock.json ./

# Устанавливаем Node.js зависимости (включая dev для сборки)
RUN npm ci

# Копируем исходный код
COPY . .

# Создаем необходимые директории и устанавливаем права доступа
RUN mkdir -p storage/framework/{sessions,views,cache} \
    && mkdir -p storage/logs \
    && mkdir -p bootstrap/cache \
    && chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache \
    && chmod 775 /var/www/storage/logs \
    && touch /var/www/identifier.sqlite \
    && chown www-data:www-data /var/www/identifier.sqlite \
    && chmod 664 /var/www/identifier.sqlite

# Создаем entrypoint скрипт
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Собираем фронтенд
RUN npm run build

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
