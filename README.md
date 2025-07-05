# LinkShorter

Сервис для сокращения ссылок (Полезен для рекламных рассылок SMS, при которых существует ограничение в количестве символов)

## Быстрый запуск

### Вариант 1: Автоматический запуск (рекомендуется)

```bash
# Склонируйте репозиторий
git clone https://github.com/KirTimohovich/LinkShorter.git

# Перейдите в каталог проекта
cd LinkShorter

# Запустите автоматический скрипт
chmod +x start.sh
./start.sh
```

### Вариант 2: Ручной запуск

```bash
# 1. Склонируйте репозиторий
git clone https://github.com/KirTimohovich/LinkShorter.git

# 2. Перейдите в каталог проекта
cd LinkShorter

# 3. Создайте .env файл (если его нет)
cp .env.example .env

# 4. Соберите и запустите Docker контейнеры
docker-compose up --build -d

# 5. Выполните миграции базы данных
docker-compose exec app php artisan migrate --force
```

## Доступ к приложению

После успешного запуска:
- 🌐 **Веб-приложение**: http://localhost:8000
- 📊 **База данных**: localhost:3306

## Управление контейнерами

```bash
# Остановить контейнеры
docker-compose down

# Просмотр логов
docker-compose logs -f

# Перезапуск
docker-compose restart

# Полная пересборка
docker-compose build --no-cache
```

## Структура проекта

- `app/` - Основной код Laravel приложения
- `resources/` - Frontend ресурсы (Vue.js компоненты)
- `database/` - Миграции и сидеры
- `docker/` - Docker конфигурация
- `public/` - Публичные файлы

## Технологии

- **Backend**: Laravel 12, PHP 8.2
- **Frontend**: Vue.js 3, Vite
- **База данных**: MySQL 8.0
- **Контейнеризация**: Docker & Docker Compose
