Сервис для сокращения ссылок (Полезен для рекламных рассылок SMS, при которых существует ограничение в количестве символов)

Быстрый запуск

Вариант 1: Автоматический запуск (рекомендуется)

1) Склонируйте репозиторий
git clone https://github.com/KirTimohovich/LinkShorter.git

2) Перейдите в каталог проекта
cd LinkShorter

3) Запустите автоматический скрипт
chmod +x start.sh
./start.sh


Вариант 2: Ручной запуск


1) Склонируйте репозиторий
git clone https://github.com/KirTimohovich/LinkShorter.git

2) Перейдите в каталог проекта
cd LinkShorter

3) Создайте .env файл (если его нет)
cp .env.example .env

4) Соберите и запустите Docker контейнеры
docker-compose up --build -d

5) Выполните миграции базы данных
docker-compose exec app php artisan migrate --force


http://localhost:8000


Управление контейнерами

1) Остановить контейнеры
docker-compose down

2) Перезапуск
docker-compose restart

3) Полная пересборка
docker-compose build --no-cache
