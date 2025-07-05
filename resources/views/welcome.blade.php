<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>URL Shortener</title>
    <!-- Только CSS, без JS -->
    @vite(['resources/sass/app.scss'])
    <style>
        .welcome-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .welcome-container h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .welcome-container p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .welcome-container a {
            color: #ffeb3b;
            text-decoration: none;
            font-weight: bold;
            margin: 0 10px;
        }
        .welcome-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="welcome-container">
    <h1>Добро пожаловать в сервис сокращения ссылок</h1>
    <p>Пожалуйста, войдите или зарегистрируйтесь для использования сервиса</p>
    <div>
        <a href="{{ route('login') }}">Войти</a>
        @if (Route::has('register'))
            <a href="{{ route('register') }}">Регистрация</a>
        @endif
    </div>
</div>
</body>
</html>
