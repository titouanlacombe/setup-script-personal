# Dockerfile to test setup.sh on multiple environments and benchmark time & storage
ARG image=ubuntu:22.10

FROM $image

ARG pm_update="apt update"
ENV pm_update=$pm_update

ARG pm_install="apt install -y"
ENV pm_install=$pm_install

# Install sudo if not already installed
RUN if ! command -v sudo; then ${pm_update} && ${pm_install} sudo; fi

# Create user and add to sudoers
RUN useradd -m -s /bin/bash -G sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER user

COPY setup.sh /setup.sh
RUN /setup.sh
