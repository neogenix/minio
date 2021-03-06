FROM golang:1.7-alpine

WORKDIR /go/src/app

COPY . /go/src/app
RUN \
	apk add --no-cache git && \
	go-wrapper download && \
	go-wrapper install -ldflags "$(go run buildscripts/gen-ldflags.go)" && \
	mkdir -p /export/docker && \
	cp /go/src/app/docs/docker/README.md /export/docker/ && \
	rm -rf /go/pkg /go/src && \
	apk del git

EXPOSE 9000
ENTRYPOINT ["go-wrapper", "run"]
VOLUME ["/export"]
