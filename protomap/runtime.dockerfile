FROM golang:alpine as downloader

ARG FROM=https://build.protomaps.com/20250521.pmtiles
ARG MAXZOOM=12

RUN go install github.com/protomaps/go-pmtiles@latest

WORKDIR /dist
RUN go-pmtiles extract ${FROM} ./output.pmtiles --maxzoom=${MAXZOOM}

ENTRYPOINT ["go-pmtiles"]