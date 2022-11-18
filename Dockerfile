# Dockerfile to test setup.sh on multiple environments and benchmark time & storage
ARG image=ubuntu:22.10

FROM $image

ARG PM_UPDATE="apt update"
ENV PM_UPDATE=$PM_UPDATE

ARG PM_UPGRADE="apt full-upgrade -y"
ENV PM_UPGRADE=$PM_UPGRADE

ARG PM_INSTALL="apt install -y"
ENV PM_INSTALL=$PM_INSTALL

# Install sudo if not already installed
RUN if ! command -v sudo; then ${PM_UPDATE} && ${PM_INSTALL} sudo; fi

# Create user and add to sudoers
RUN useradd -m -s /bin/bash -G sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user

COPY setup.sh /setup.sh
RUN sudo sh ./setup.sh
