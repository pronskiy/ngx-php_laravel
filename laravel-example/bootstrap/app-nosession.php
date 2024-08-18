<?php

use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Foundation\Http\Middleware\ValidateCsrfToken;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;

$app = include './app.php';
$app->withMiddleware(function (Middleware $middleware) {
    $middleware->web(remove: [StartSession::class,
        ShareErrorsFromSession::class,
        ValidateCsrfToken::class,
    ]);
});
return $app;
