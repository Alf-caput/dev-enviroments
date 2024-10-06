FROM ubuntu:latest

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git

# Install Oh My Posh
RUN wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
RUN chmod +x /usr/local/bin/oh-my-posh

# Download probua.minimal theme
RUN mkdir -p ~/.poshthemes
RUN wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/probua.minimal.omp.json -O ~/.poshthemes/probua.minimal.omp.json

# Set up Oh My Posh configuration
RUN echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/probua.minimal.omp.json)"' >> ~/.bashrc

# Set the entry point to start a bash shell
ENTRYPOINT ["/bin/bash"]
