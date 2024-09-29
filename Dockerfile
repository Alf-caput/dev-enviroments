FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /workspace

CMD ["/bin/sh"]
