FROM protomaps/go-pmtiles

ARG FROM=https://build.protomaps.com/20250521.pmtiles
ARG MAXZOOM=12

WORKDIR /dist
RUN go-pmtiles extract ${FROM} ./output.pmtiles --maxzoom=${MAXZOOM}

