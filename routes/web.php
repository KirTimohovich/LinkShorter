<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LinkController;

Route::get('/', [LinkController::class, 'index'])->name('index');
Route::post('/shorten', [LinkController::class, 'create'])->name('shorten');
Route::get('/links', [LinkController::class, 'indexLinks']);
Route::get('/{shortUrl}', [LinkController::class, 'redirect']);
Route::delete('/links', [LinkController::class, 'clearLinks']);
