FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /root/workspace

LABEL devcontainer.metadata="{ \
  \"customizations\": { \
    \"vscode\": { \
      \"settings\": { \
        \"workbench.iconTheme\": \"vscode-icons\", \
        \"files.insertFinalNewline\": true \
      }, \
      \"extensions\": [ \
        \"vscode-icons-team.vscode-icons\", \
      ] \
    } \
  } \
}"

COPY . .

CMD ["/bin/sh"]
