# Use Alpine as the base image
FROM alpine:latest

# Install git
RUN apk add --no-cache git

# Set repository variables
ENV REPO_URL=https://github.com/Alf-caput/simple-tests.git
ENV REPO_NAME=simple-tests

# Set working directory
WORKDIR /workspace/${REPO_NAME}

# Create a volume that will be mounted
VOLUME /workspace/${REPO_NAME}

# Clone the repository if cwd is not a Git repository
CMD ["/bin/sh", "-c", "\
if $(git rev-parse --is-inside-work-tree 2>/dev/null); then \
    echo 'Already a Git directory. Skipping clone...'; \
else \
    echo 'Cloning...' && \
    git clone ${REPO_URL} . && \
    clear; \
fi; \
/bin/sh"]
