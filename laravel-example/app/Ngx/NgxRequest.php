<?php

namespace App\Ngx;

use Illuminate\Http\Request;

class NgxRequest extends Request
{
    public static function new()
    {
        $uri = ngx_request_uri();
        $method = ngx_request_method();
        $parameters = ngx_query_args(); // @FIXME Add post args
        $cookies = self::cookieStringToArray(ngx_cookie_get_all());

        $server = [
            'SERVER_NAME' => ngx_request_server_name(),
            'SERVER_PORT' => ngx_request_server_port(),
            'REMOTE_ADDR' => ngx_request_remote_addr(),
            'SERVER_PROTOCOL' => ngx_request_server_protocol(),
        ];

        return parent::createFromBase(parent::create($uri, $method, $parameters, $cookies, server: $server));
    }

    public static function cookieStringToArray(?string $cookieString): array
    {
        if (empty($cookieString)) {
            return [];
        }

        $cookies = array();
        $lines = explode(';', $cookieString);

        foreach($lines as $line) {
            $cookieString = explode('=', $line);
            $name = trim($cookieString[0]);
            $value = trim($cookieString[1]);
            $cookies[$name] = $value;
        }

        return $cookies;
    }
}
