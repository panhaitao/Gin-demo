# build stage
FROM alpine:3.14 as build-stage

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk --no-cache add go ca-certificates
RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -pv /src                       && \
    cd /src                              && \
    go mod init src                      && \
    go env -w GOPROXY=https://goproxy.cn && \
    go get github.com/gin-gonic/gin
COPY main.go /src
RUN cd /src && go build main.go

# production stage
#FROM scratch
FROM alpine:3.14
WORKDIR /
COPY --from=build-stage /src/main /
RUN chmod 755 /main
EXPOSE 8000

CMD ["/main"]
