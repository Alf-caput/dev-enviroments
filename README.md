## DEV-ENVIROMENTS IN VSCODE

The extension `ms-vscode-remote.remote-containers` from vscode isn't very consistent, and  when using build or open in container automatically creates undesired images with confusing names. 

In this brief repository will be shown a cleaner approach to work with containers while avoiding creating Microsoft's images, so your enviroment is reproduceable by other developers easily (VS Code will be the editor of choice in this case and git will be the main feature).

Here are the steps someone that would like to contribute / work with our repositories will do:

1. Installations
    - VS Code
    - Git
    - Docker

2. Configurations
    - .gitconfig
    - ssh

3. Clone remote repository to local machine

4. Build image from Dockerfile / Pull image from DockerHub

5. Run container
    - Bind mount .gitconfig
    - Bind mount ssh
    - Bind mount repository

6. Attach container to VS Code
    - Open workspace (only first time)
    - Install extensions suggested by author (.vscode/)

This guide will skip installing and setting up configurations.

Once everything is installed and configured, user way of proceeding should be to clone the repository in the host machine, it is possible to clone in a volume but that won't be covered in this example.

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```

Next the user will build a docker image using the Dockerfile that lives in the repository.

```bash
docker build -t IMAGE-NAME .
```

Note: It is also possible to pull an existing image. 

The Dockerfile that is provided in this example is only suited for using git in ubuntu, but feel free to add further functionality:

```bash
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git

WORKDIR /workspace

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
    --volume /HOST/PATH/.gitconfig:/root/.gitconfig \
    --volume .:/root/workspace \
    IMAGE-NAME
```

Note: For ubuntu `/HOST/PATH/.gitconfig` is usually `~/.gitconfig`

Now in VS Code open command palette (Ctrl+Shift+p) and use Dev Containers: Attach to running container
