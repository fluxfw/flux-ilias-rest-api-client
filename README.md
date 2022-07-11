# flux-ilias-rest-api-client

ILIAS Rest Api Client

## Installation

### Native

#### Download

```dockerfile
RUN (mkdir -p /%path%/libs/flux-ilias-rest-api-client && cd /%path%/libs/flux-ilias-rest-api-client && wget -O - https://github.com/flux-eco/flux-ilias-rest-api-client/releases/download/%tag%/flux-ilias-rest-api-client-%tag%-build.tar.gz | tar -xz --strip-components=1)
```

or

Download https://github.com/flux-eco/flux-ilias-rest-api-client/releases/download/%tag%/flux-ilias-rest-api-client-%tag%-build.tar.gz and extract it to `/%path%/libs/flux-ilias-rest-api-client`

#### Load

```php
require_once __DIR__ . "/%path%/libs/flux-ilias-rest-api-client/autoload.php";
```

### Composer

```json
{
    "repositories": [
        {
            "type": "package",
            "package": {
                "name": "flux/flux-ilias-rest-api-client",
                "version": "%tag%",
                "dist": {
                    "url": "https://github.com/flux-eco/flux-ilias-rest-api-client/releases/download/%tag%/flux-ilias-rest-api-client-%tag%-build.tar.gz",
                    "type": "tar"
                },
                "autoload": {
                    "files": [
                        "autoload.php"
                    ]
                }
            }
        }
    ],
    "require": {
        "flux/flux-ilias-rest-api-client": "*"
    }
}
```

## Environment variables

| Variable | Description | Default value |
|----------| ----------- | ------------- |
| **FLUX_ILIAS_REST_API_CLIENT_URL** | ILIAS url | - |
| FLUX_ILIAS_REST_API_CLIENT_CLIENT | ILIAS client<br>Use *FLUX_ILIAS_REST_API_CLIENT_CLIENT_FILE* for docker secrets | default |
| **FLUX_ILIAS_REST_API_CLIENT_USER** | ILIAS user<br>Use *FLUX_ILIAS_REST_API_CLIENT_USER_FILE* for docker secrets | - |
| **FLUX_ILIAS_REST_API_CLIENT_PASSWORD** | ILIAS password<br>Use *FLUX_ILIAS_REST_API_CLIENT_PASSWORD_FILE* for docker secrets | - |
| FLUX_ILIAS_REST_API_CLIENT_TRUST_SELF_SIGNED_CERTIFICATE | If you use a self signed certificate, you need to trust it manually | false |
| FLUX_ILIAS_REST_API_CLIENT_NGINX_SERVER | If flux-ilias-rest-api is on a Nginx server, you need to enable a workaround for supports all HTTP methods, you need to disable it for support Apache | true |

Minimal variables required to set are **bold**
