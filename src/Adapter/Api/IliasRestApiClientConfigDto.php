<?php

namespace FluxIliasRestApiClient\Adapter\Api;

class IliasRestApiClientConfigDto
{

    private function __construct(
        public readonly string $url,
        public readonly string $user,
        public readonly string $password,
        public readonly string $client,
        public readonly bool $trust_self_signed_certificate,
        public readonly bool $nginx_server
    ) {

    }


    public static function new(
        string $url,
        string $user,
        string $password,
        ?string $client = null,
        ?bool $trust_self_signed_certificate = null,
        ?bool $nginx_server = null
    ) : static {
        return new static(
            $url,
            $user,
            $password,
            $client ?? "default",
            $trust_self_signed_certificate ?? false,
            $nginx_server ?? true
        );
    }


    public static function newFromEnv() : static
    {
        return static::new(
            $_ENV["FLUX_ILIAS_REST_API_CLIENT_URL"],
            ($_ENV["FLUX_ILIAS_REST_API_CLIENT_CLIENT"] ?? null) ??
            (($client_file = $_ENV["FLUX_ILIAS_REST_API_CLIENT_CLIENT_FILE"] ?? null) !== null && file_exists($client_file) ? rtrim(file_get_contents($client_file) ?: "", "\n\r") : null),
            ($_ENV["FLUX_ILIAS_REST_API_CLIENT_USER"] ?? null) ??
            (($user_file = $_ENV["FLUX_ILIAS_REST_API_CLIENT_USER_FILE"] ?? null) !== null && file_exists($user_file) ? rtrim(file_get_contents($user_file) ?: "", "\n\r") : null),
            ($_ENV["FLUX_ILIAS_REST_API_CLIENT_PASSWORD"] ?? null) ??
            (($password_file = $_ENV["FLUX_ILIAS_REST_API_CLIENT_PASSWORD_FILE"] ?? null) !== null && file_exists($password_file) ? rtrim(file_get_contents($password_file) ?: "", "\n\r") : null),
            ($trust_self_signed_certificate = $_ENV["FLUX_ILIAS_REST_API_CLIENT_TRUST_SELF_SIGNED_CERTIFICATE"] ?? null) !== null ? in_array($trust_self_signed_certificate, ["true", "1"]) : null,
            ($nginx_server = $_ENV["FLUX_ILIAS_REST_API_CLIENT_NGINX_SERVER"] ?? null) !== null ? in_array($nginx_server, ["true", "1"]) : null
        );
    }
}
