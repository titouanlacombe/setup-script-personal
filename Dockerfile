FROM ubuntu:22.10

# Install sudo if not already installed
RUN if ! command -v sudo; then apt update && apt install -y sudo; fi

# Create user and add to sudoers
RUN useradd -m -s /bin/bash -G sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user

COPY *.sh ./
RUN cat ubuntu.sh main.sh | sh
