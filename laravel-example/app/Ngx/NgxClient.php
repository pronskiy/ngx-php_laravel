<?php

namespace App\Ngx;

use Illuminate\Foundation\Application;
use Illuminate\Http\Request;
use Laravel\Octane\Contracts\Client;
use Laravel\Octane\OctaneResponse;
use Laravel\Octane\RequestContext;
use Throwable;

class NgxClient implements Client
{

    public function marshalRequest(RequestContext $context): array
    {
        $request = NgxRequest::new();
        return [
            $request,
            $context,
        ];
    }

    public function respond(RequestContext $context, OctaneResponse $response): void
    {
        ob_start();
        echo $response->response->getContent();
        ob_end_flush();
        ngx_exit($response->response->getStatusCode());
    }

    public function error(Throwable $e, Application $app, Request $request, RequestContext $context): void
    {
        echo $e->getMessage();
    }
}
