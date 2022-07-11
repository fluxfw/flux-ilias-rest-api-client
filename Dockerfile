ARG FLUX_AUTOLOAD_API_IMAGE
ARG FLUX_ILIAS_BASE_API_IMAGE
ARG FLUX_NAMESPACE_CHANGER_IMAGE=docker-registry.fluxpublisher.ch/flux-namespace-changer
ARG FLUX_REST_API_IMAGE

FROM $FLUX_AUTOLOAD_API_IMAGE:v2022-06-22-1 AS flux_autoload_api
FROM $FLUX_ILIAS_BASE_API_IMAGE:v2022-07-05-1 AS flux_ilias_base_api
FROM $FLUX_REST_API_IMAGE:v2022-07-11-1 AS flux_rest_api

FROM $FLUX_NAMESPACE_CHANGER_IMAGE:v2022-06-23-1 AS build_namespaces

COPY --from=flux_autoload_api /flux-autoload-api /code/flux-autoload-api
RUN change-namespace /code/flux-autoload-api FluxAutoloadApi FluxIliasRestApiClient\\Libs\\FluxAutoloadApi

COPY --from=flux_ilias_base_api /flux-ilias-base-api /code/flux-ilias-base-api
RUN change-namespace /code/flux-ilias-base-api FluxIliasBaseApi FluxIliasRestApiClient\\Libs\\FluxIliasBaseApi

COPY --from=flux_rest_api /flux-rest-api /code/flux-rest-api
RUN change-namespace /code/flux-rest-api FluxRestApi FluxIliasRestApiClient\\Libs\\FluxRestApi

FROM alpine:latest AS build

COPY --from=build_namespaces /code/flux-autoload-api /build/flux-ilias-rest-api-client/libs/flux-autoload-api
COPY --from=build_namespaces /code/flux-ilias-base-api /build/flux-ilias-rest-api-client/libs/flux-ilias-base-api
COPY --from=build_namespaces /code/flux-rest-api /build/flux-ilias-rest-api-client/libs/flux-rest-api
COPY . /build/flux-ilias-rest-api-client

RUN (cd /build && tar -czf flux-ilias-rest-api-client.tar.gz flux-ilias-rest-api-client)

FROM scratch

LABEL org.opencontainers.image.source="https://github.com/flux-eco/flux-ilias-rest-api-client"
LABEL maintainer="fluxlabs <support@fluxlabs.ch> (https://fluxlabs.ch)"

COPY --from=build /build /

ARG COMMIT_SHA
LABEL org.opencontainers.image.revision="$COMMIT_SHA"
