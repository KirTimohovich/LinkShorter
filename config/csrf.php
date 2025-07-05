<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Site Request Forgery (CSRF) Protection
    |--------------------------------------------------------------------------
    |
    | Here you may configure the CSRF protection settings for your application.
    | By default, Laravel will use the "web" middleware group to apply CSRF
    | protection to all routes. You may also exclude specific routes from
    | CSRF protection by adding them to the "except" array.
    |
    */

    'guard' => env('CSRF_GUARD', 'web'),

    'except' => [
        //
    ],

    /*
    |--------------------------------------------------------------------------
    | CSRF Token Name
    |--------------------------------------------------------------------------
    |
    | Here you may change the name of the CSRF token that is used for
    | CSRF protection. By default, Laravel will use "csrf-token".
    |
    */

    'token_name' => env('CSRF_TOKEN_NAME', 'csrf-token'),

    /*
    |--------------------------------------------------------------------------
    | CSRF Token Length
    |--------------------------------------------------------------------------
    |
    | Here you may specify the length of the CSRF token. By default, Laravel
    | will generate a 40 character token.
    |
    */

    'token_length' => env('CSRF_TOKEN_LENGTH', 40),

    /*
    |--------------------------------------------------------------------------
    | CSRF Token Expiration
    |--------------------------------------------------------------------------
    |
    | Here you may specify how long the CSRF token should be valid. By
    | default, Laravel will regenerate the token on each request.
    |
    */

    'token_expiration' => env('CSRF_TOKEN_EXPIRATION', null),

]; 