<?php

use App\Ngx\NgxClient;
use Laravel\Octane\ApplicationFactory;
use Laravel\Octane\RequestContext;
use Laravel\Octane\Worker;

ini_set('memory_limit', '-1');

require_once __DIR__ . '/../vendor/autoload.php';

$_ENV['APP_ENV'] = 'prod';
$_ENV['APP_BASE_PATH'] = __DIR__ . '/../';
$_ENV['LARAVEL_OCTANE'] = 1;

$basePath = require __DIR__.'/../vendor/laravel/octane/bin/bootstrap.php';

$ngxClient = new NgxClient();

/** @var Worker $worker */
$worker = $worker ?? tap((new Worker(
    new ApplicationFactory($basePath), $ngxClient
)))->boot();

function onRequest()
{
    global $worker, $ngxClient;

    [$request, $requestContext] = $ngxClient->marshalRequest(new RequestContext());

    $worker->handle($request, $requestContext);
}
