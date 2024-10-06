FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git \
    curl

RUN curl -s https://ohmyposh.dev/install.sh | bash -s

WORKDIR /workspace

CMD ["/bin/sh"]
