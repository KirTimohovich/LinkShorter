<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'URL Shortener') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=inter:400,500,600,700" rel="stylesheet" />
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="{{ asset('css/url-shortener.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Vite Assets -->
    @vite(['resources/sass/app.scss', 'resources/js/app.js'])
</head>
<body class="font-sans antialiased">
<div id="app">
    <nav class="app-nav">
        <div class="nav-container">
            <div class="nav-content">
                <div class="nav-left">
                    <div class="nav-brand">
                        <a href="{{ route('home') }}" class="nav-link">
                            URL Shortener
                        </a>
                    </div>
                </div>

                <div class="nav-right">
                    @auth
                        <div class="nav-user">
                            <div class="user-info">
                                <span class="user-name">{{ Auth::user()->name }}</span>
                                <form method="POST" action="{{ route('logout') }}" class="logout-form">
                                    @csrf
                                    <button type="submit" class="logout-btn">
                                        Выйти
                                    </button>
                                </form>
                            </div>
                        </div>
                    @else
                        <div class="nav-auth">
                            <a href="{{ route('login') }}" class="nav-auth-link">Войти</a>
                            @if (Route::has('register'))
                                <a href="{{ route('register') }}" class="nav-auth-link">Регистрация</a>
                            @endif
                        </div>
                    @endauth
                </div>
            </div>
        </div>
    </nav>

    <main class="app-main">
        @yield('content')
    </main>
</div>
</body>
</html>
