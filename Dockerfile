FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /root/workspace

COPY . .

CMD ["/bin/sh"]
