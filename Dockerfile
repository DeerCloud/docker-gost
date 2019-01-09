FROM golang:alpine as builder

LABEL maintainer="metowolf <i@i-meto.com>"

ENV VERSION 2.7.1

RUN apk add git \
  && cd /go/src \
  && wget https://github.com/ginuerzh/gost/archive/v$VERSION.tar.gz \
  && tar xzvf v$VERSION.tar.gz \
  && go get gost-$VERSION/cmd/gost


FROM alpine:3.8

LABEL maintainer="metowolf <i@i-meto.com>"

ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT 8080
ENV DNS 8.8.8.8,8.8.4.4
ENV PROTOCOL socks5
ENV TRANSPORT tcp
ENV USERNAME=
ENV PASSWORD=

EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp

COPY --from=builder /go/bin/gost /usr/local/bin/

COPY entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]
