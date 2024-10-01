# https://hub.docker.com/r/alfcaput/debian-git-python-vscode
# docker pull alfcaput/debian-git-python-vscode
FROM python:slim-bullseye

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /root/workspace

COPY requirements.txt .

RUN pip install -r requirements.txt

LABEL devcontainer.metadata="{ \
  \"customizations\": { \
    \"vscode\": { \
      \"settings\": { \
        \"workbench.iconTheme\": \"vscode-icons\", \
        \"files.insertFinalNewline\": true \
      }, \
      \"extensions\": [ \
        \"vscode-icons-team.vscode-icons\" \
        \"donjayamanne.python-extension-pack\" \
        \"ms-toolsai.jupyter\" \
      ] \
    } \
  } \
}"

COPY . .

CMD ["/bin/sh"]
