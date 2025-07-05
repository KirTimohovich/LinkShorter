Сервис для сокращения ссылкок (Полезен для рекламных рассылок смс при которых существует ограничение в кол-ве символов)
Для подключения проекта:
1) Склонируйте репозиторий
   (git clone https://github.com/KirTimohovich/LinkShorter.git)

2) Перейдите в каталог проекта (cd LinkShorter)

3) copy .env.example .env

4) php artisan key:generate
   
5) Запустить с Docker
   (docker compose up --build)

Теперь ваш проект должен быть доступен по адресу http://localhost:8000
