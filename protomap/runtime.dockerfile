FROM golang:latest as downloader

ARG FROM=https://build.protomaps.com/20250521.pmtiles
ARG MAXZOOM=12

RUN go install github.com/protomaps/go-pmtiles@latest

FROM busybox

COPY --from=downloader /go/bin/pmtiles /bin/go-pmtiles
WORKDIR /dist
RUN go-pmtiles extract ${FROM} ./output.pmtiles --maxzoom=${MAXZOOM}

ENTRYPOINT ["go-pmtiles"]