FROM alpine:latest

RUN apk update && \
    apk add --no-cache git

WORKDIR /workspace

CMD ["/bin/sh"]
