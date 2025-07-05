<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | Этот контроллер обрабатывает аутентификацию пользователей
    | и перенаправляет их на главную страницу.
    |
    */

    use AuthenticatesUsers; // Критически важный трейт

    /**
     * Куда перенаправлять после входа
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Создание нового экземпляра контроллера
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }
}
