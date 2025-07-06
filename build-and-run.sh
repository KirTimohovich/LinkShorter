#!/bin/bash

echo "🚀 Сборка и запуск URL Shortener в Docker..."

# Останавливаем существующие контейнеры
echo "📦 Останавливаем существующие контейнеры..."
docker-compose down

# Удаляем старые образы (опционально)
echo "🧹 Очистка старых образов..."
docker-compose build --no-cache

# Собираем и запускаем контейнеры
echo "🔨 Сборка контейнеров..."
docker-compose up --build -d

# Ждем немного для запуска
echo "⏳ Ожидание запуска контейнеров..."
sleep 10

# Проверяем статус
echo "📊 Статус контейнеров:"
docker-compose ps

echo "✅ Приложение запущено!"
echo "🌐 Доступно по адресу: http://localhost:8000"
echo "📝 Логи приложения: docker-compose logs -f app"
echo "🌐 Логи nginx: docker-compose logs -f nginx" 