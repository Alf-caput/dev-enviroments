# dev-enviroments
Containers for developing in vscode

Query to perplexity.ai: 
- In depth guide on how to create a simple docker container and edit inside it using vscode ssh extension, only by having vscode installed in the host

We will need vscode installed in the host machine with the extensions Remote - SSH and Remote - Containers

```bash
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openssh-server \
    vim

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

We build the image

```bash
docker build -t vscode-ssh-container .
```

And run the container using port 2222 of the host as port 22 of the container

```bash
docker run -d -p 2222:22 --name vscode-container vscode-ssh-container
```

We add to ~/.ssh/config in Linux or C:\Users\\username\\.ssh\\config in Windows (if not existent create it) the following:

```bash
Host docker-container
    HostName localhost
    Port 2222
    User root
    StrictHostKeyChecking no
```

Note: On Windows I'm using docker with WSL and creating C:\Users\\username\\.ssh\\config worked

And thats it!

Connect to the container using VS Code:

- Open the Command Palette (Ctrl+Shift+P)
- Select "Remote-SSH: Connect to Host..."
- Choose "docker-container"
When prompted, enter the password "password"
Once connected, we can open a folder in the container.

We may want to add new tools and persist the changes in the image (not recommended if adding sensitive information), we can persist changes:

```bash
docker commit vscode-container vscode-ssh-container:v2
```
