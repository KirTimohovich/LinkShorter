@extends('layouts.app')

@section('content')
<div class="app-container">
    <div class="background"></div>
    <div class="content">
        <div class="card">
            <div class="title">Регистрация</div>
            
            <form method="POST" action="{{ route('register') }}" class="auth-form">
                @csrf

                <div class="form-group">
                    <label for="name" class="form-label">
                        <i class="fa-solid fa-user"></i>
                        Имя
                    </label>
                    <input 
                        id="name" 
                        type="text" 
                        class="form-input @error('name') is-invalid @enderror" 
                        name="name" 
                        value="{{ old('name') }}" 
                        required 
                        autocomplete="name" 
                        autofocus
                        placeholder="Введите ваше имя"
                    >
                    @error('name')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">
                        <i class="fa-solid fa-envelope"></i>
                        Email адрес
                    </label>
                    <input 
                        id="email" 
                        type="email" 
                        class="form-input @error('email') is-invalid @enderror" 
                        name="email" 
                        value="{{ old('email') }}" 
                        required 
                        autocomplete="email"
                        placeholder="Введите ваш email"
                    >
                    @error('email')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">
                        <i class="fa-solid fa-lock"></i>
                        Пароль
                    </label>
                    <input 
                        id="password" 
                        type="password" 
                        class="form-input @error('password') is-invalid @enderror" 
                        name="password" 
                        required 
                        autocomplete="new-password"
                        placeholder="Введите пароль"
                    >
                    <div class="password-hint">
                        <i class="fa-solid fa-info-circle"></i>
                        Минимум 8 символов
                    </div>
                    @error('password')
                        <div class="error-message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            {{ $message }}
                        </div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="password-confirm" class="form-label">
                        <i class="fa-solid fa-lock"></i>
                        Подтвердите пароль
                    </label>
                    <input 
                        id="password-confirm" 
                        type="password" 
                        class="form-input" 
                        name="password_confirmation" 
                        required 
                        autocomplete="new-password"
                        placeholder="Повторите пароль"
                    >
                </div>

                <div class="form-actions">
                    <button type="submit" class="submit-btn">
                        <i class="fa-solid fa-user-plus"></i>
                        Зарегистрироваться
                    </button>
                </div>
            </form>

            <div class="auth-footer">
                <span>Уже есть аккаунт?</span>
                <a href="{{ route('login') }}" class="auth-link">
                    Войти
                </a>
            </div>
        </div>
    </div>
</div>
@endsection
