## DEV-ENVIROMENTS IN VSCODE

The extension `ms-vscode-remote.remote-containers` from vscode isn't very consistent, and when using build or open in container automatically creates undesired images with confusing names. 

In this brief repository will be shown a cleaner approach to work with containers while avoiding creating Microsoft's images, so your enviroment is reproduceable by other developers easily (VS Code will be the editor of choice in this case and Git will be the main feature).

Here are the steps someone that would like to contribute / work should do:

1. Installations
    - VS Code
    - Git
    - Docker

2. Configurations
    - .gitconfig
    - ssh

3. Clone remote repository to local machine

4. Build image from Dockerfile / Pull image from remote

5. Run container
    - Bind mount .gitconfig
    - Bind mount ssh
    - Bind mount repository

6. Attach container to VS Code
    - Open workspace (only first time)
    - Install extensions suggested by author (defined at `.vscode/`)

This guide will skip installing and setting up configurations.

Once everything is installed and configured, user way of proceeding should be to clone the repository in the host machine, it is possible to clone in a volume but that won't be covered here.

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```

In this example:
```bash
git clone https://github.com/Alf-caput/dev-enviroments.git
```

Next the user will build a docker image using the Dockerfile that lives in the repository.

```bash
docker build -t IMAGE-NAME .
```

Note: It is also possible to pull an existing image. 

Example:

```bash
docker build -t alfcaput/ubuntu-git .
```

or

```bash
docker pull -t alfcaput/ubuntu-git .
```

The Dockerfile that is provided in this example is only suited for using git in ubuntu, but feel free to add further functionality:

```bash
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /root/workspace

COPY . .

CMD ["/bin/sh"]

```

That done, the user will be able to build containers using the image, however, some considerations should be taken into account.

The idea is to create an enviroment that only differs from the author in terms of credentials, this is extensions and also should be easy to set user's credentials in the container.

For extensions it is possible to suggest them using .vscode/extensions.json

During runtime bind mounts are used for credentials and for the repository (Will be saved in /workspace directory of the container).

```bash
docker run \
    -d \
    -it \
    --name CONTAINER-NAME \
    --volume /HOST/PATH/TO/.gitconfig:/root/.gitconfig:ro \
    IMAGE-NAME
```

Note: For ubuntu `/HOST/PATH/TO/.gitconfig` is usually `~/.gitconfig`

Example:

```bash
docker run \
    -d \
    -it \
    --name  dev-enviroments-container \
    --volume ~/.gitconfig:/root/.gitconfig:ro \
    alfcaput/ubuntu-git
```

Now in VS Code open command palette (Ctrl+Shift+p) and use `Dev Containers: Attach to running container ...` this will open a new instance of VS Code this time running inside the container, you can find your repository workspace at `/root/workspace/YOUR-REPOSITORY` (In this example `/root/workspace/dev-enviroments`).

The next time you start/run a container with the same image name (which is inconsistent but is VS Code way of saving configurations) the workspace selected folder, container extensions and other VS Code configurations related to the container will be reused.

You can check your git credentials live in the container, `.gitconfig` was bind mounted into `/root/.gitconfig` in the container
