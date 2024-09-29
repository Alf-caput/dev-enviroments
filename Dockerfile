FROM ubuntu:latest

RUN apt-get update && apt-get install -y git

COPY GIT_CONFIG_PATH dest

CMD ["bash"]
