FROM alpine

RUN apk update
RUN apk add make go git gcc libc-dev && rm -rf /var/cache/apk/*

ENV GOPATH /go
ENV PLUGINDIR /go/src/github.com/anusha-ragunathan/global-net-plugin

RUN mkdir -p /run/docker/plugins

COPY . ${PLUGINDIR}
WORKDIR ${PLUGINDIR}

RUN go install --ldflags '-extldflags "-static"'
RUN mv /go/bin/global-net-plugin /bin

CMD ["/bin/global-net-plugin"]
