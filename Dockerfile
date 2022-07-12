FROM php:cli-alpine AS build

RUN (mkdir -p /flux-namespace-changer && cd /flux-namespace-changer && wget -O - https://github.com/flux-eco/flux-namespace-changer/releases/download/v2022-07-12-1/flux-namespace-changer-v2022-07-12-1-build.tar.gz | tar -xz --strip-components=1)

RUN (mkdir -p /build/flux-ilias-rest-api-client/libs/flux-autoload-api && cd /build/flux-ilias-rest-api-client/libs/flux-autoload-api && wget -O - https://github.com/flux-eco/flux-autoload-api/releases/download/v2022-07-12-1/flux-autoload-api-v2022-07-12-1-build.tar.gz | tar -xz --strip-components=1 && /flux-namespace-changer/bin/change-namespace.php . FluxAutoloadApi FluxIliasRestApiClient\\Libs\\FluxAutoloadApi)

RUN (mkdir -p /build/flux-ilias-rest-api-client/libs/flux-ilias-base-api && cd /build/flux-ilias-rest-api-client/libs/flux-ilias-base-api && wget -O - https://github.com/flux-eco/flux-ilias-base-api/releases/download/v2022-07-12-1/flux-ilias-base-api-v2022-07-12-1-build.tar.gz | tar -xz --strip-components=1 && /flux-namespace-changer/bin/change-namespace.php . FluxIliasBaseApi FluxIliasRestApiClient\\Libs\\FluxIliasBaseApi)

RUN (mkdir -p /build/flux-ilias-rest-api-client/libs/flux-rest-api && cd /build/flux-ilias-rest-api-client/libs/flux-rest-api && wget -O - https://github.com/flux-eco/flux-rest-api/releases/download/v2022-07-12-1/flux-rest-api-v2022-07-12-1-build.tar.gz | tar -xz --strip-components=1 && /flux-namespace-changer/bin/change-namespace.php . FluxRestApi FluxIliasRestApiClient\\Libs\\FluxRestApi)

COPY . /build/flux-ilias-rest-api-client

FROM scratch

COPY --from=build /build /
