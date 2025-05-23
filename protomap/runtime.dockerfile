FROM golang:alpine as stage_download_tools

ARG FROM=https://build.protomaps.com/20250521.pmtiles
ARG MAXZOOM=12

RUN go install github.com/protomaps/go-pmtiles@latest

RUN cp $(which go-pmtiles) /go-pmtiles

FROM busybox

COPY --from=stage_download_tools /go-pmtiles /bin/go-pmtiles
WORKDIR /dist
RUN go-pmtiles extract ${FROM} ./output.pmtiles --maxzoom=${MAXZOOM}

ENTRYPOINT ["go-pmtiles"]