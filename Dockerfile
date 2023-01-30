FROM php:8.2-cli-alpine AS build

RUN (mkdir -p /build/flux-ilias-rest-api-client/libs/flux-ilias-base-api && cd /build/flux-ilias-rest-api-client/libs/flux-ilias-base-api && wget -O - https://github.com/fluxfw/flux-ilias-base-api/archive/refs/tags/v2023-01-30-1.tar.gz | tar -xz --strip-components=1)

RUN (mkdir -p /build/flux-ilias-rest-api-client/libs/flux-rest-api && cd /build/flux-ilias-rest-api-client/libs/flux-rest-api && wget -O - https://github.com/fluxfw/flux-rest-api/archive/refs/tags/v2023-01-30-1.tar.gz | tar -xz --strip-components=1)

COPY . /build/flux-ilias-rest-api-client

FROM scratch

COPY --from=build /build /
