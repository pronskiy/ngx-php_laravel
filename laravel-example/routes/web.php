<?php

use Illuminate\Foundation\Http\Middleware\ValidateCsrfToken;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\Support\Facades\Route;
use Illuminate\View\Middleware\ShareErrorsFromSession;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/nosession', function () {
    return view('welcome');
})->withoutMiddleware([StartSession::class,ShareErrorsFromSession::class,ValidateCsrfToken::class]);
