FROM python:slim-bullseye

RUN apt-get update && \
    apt-get install -y \
    git \
    graphviz

WORKDIR /workspace

COPY requirements.txt .

RUN pip install -r requirements.txt

CMD ["/bin/sh"]
