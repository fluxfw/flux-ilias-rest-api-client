FROM php:8.2-cli-alpine AS build

COPY bin/install-libraries.sh /build/flux-ilias-rest-api-client-build/libs/flux-ilias-rest-api-client/bin/install-libraries.sh
RUN /build/flux-ilias-rest-api-client-build/libs/flux-ilias-rest-api-client/bin/install-libraries.sh

COPY . /build/flux-ilias-rest-api-client-build/libs/flux-ilias-rest-api-client

RUN cp -L -R /build/flux-ilias-rest-api-client-build/libs/flux-ilias-rest-api-client /build/flux-ilias-rest-api-client && rm -rf /build/flux-ilias-rest-api-client/bin && rm -rf /build/flux-ilias-rest-api-client-build

RUN (cd /build && tar -czf build.tar.gz flux-ilias-rest-api-client && rm -rf flux-ilias-rest-api-client)

FROM scratch

COPY --from=build /build /
