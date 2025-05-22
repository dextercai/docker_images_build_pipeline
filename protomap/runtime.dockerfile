FROM golang:latest as downloader

ARG FROM=https://build.protomaps.com/20250521.pmtiles
ARG MAXZOOM=12

RUN go install github.com/protomaps/go-pmtiles@latest
WORKDIR /dist
RUN go-pmtiles extract ${FROM} ./output.pmtiles --maxzoom=${MAXZOOM}

FROM protomaps/go-pmtiles

WORKDIR /dist

COPY --from=downloader /dist/output.pmtiles /dist/output.pmtiles 