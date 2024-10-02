FROM python:slim-bullseye

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /root/workspace

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["/bin/sh"]
