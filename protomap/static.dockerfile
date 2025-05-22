FROM busybox

WORKDIR /dist
COPY ./output/output.pmtiles /dist/output.pmtiles

