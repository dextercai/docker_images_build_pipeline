ARG ARCH=

FROM ${ARCH}alpine:latest as builder

RUN apk update && apk add make gcc git libc-dev openssh-client

WORKDIR /tmp
RUN git clone https://github.com/pcherenkov/udpxy.git \
    && cd udpxy/chipmunk \
    && make && make install

FROM ${ARCH}alpine:latest

COPY --from=builder /usr/local/bin/udpxy /usr/local/bin/udpxy
COPY --from=builder /usr/local/bin/udpxrec /usr/local/bin/udpxrec

EXPOSE 4000/tcp

ENTRYPOINT ["/usr/local/bin/udpxy"]
CMD ["-v", "-T", "-p", "4000"]