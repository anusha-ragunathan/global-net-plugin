FROM alpine

RUN apk update
RUN apk add make go git gcc libc-dev && rm -rf /var/cache/apk/*

ENV GOPATH /go
ENV PLUGINDIR /go/src/github.com/mavenugo/test-docker-netplugin

RUN mkdir -p /run/docker/plugins

COPY . ${PLUGINDIR}
WORKDIR ${PLUGINDIR}

RUN go install --ldflags '-extldflags "-static"'

CMD ["/go/bin/test-docker-netplugin"]
