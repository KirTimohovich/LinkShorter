<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LinkController;
use App\Http\Controllers\HomeController;

Route::get('/', function () {
    return auth()->check() ? redirect('/home') : view('welcome');
});

// Подключаем роуты
require __DIR__.'/auth.php';

Route::middleware('auth')->group(function () {
    Route::get('/home', [HomeController::class, 'index'])->name('home');
    Route::post('/shorten', [LinkController::class, 'create'])->name('shorten');
    Route::get('/links', [LinkController::class, 'indexLinks']);
    Route::delete('/links', [LinkController::class, 'clearLinks']);
});

// Роут для редиректа
Route::get('/{shortUrl}', [LinkController::class, 'redirect']);
