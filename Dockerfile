ARG distro=ubuntu
ARG tag=22.10

FROM ${distro}:${tag}

ARG distro=ubuntu

# Copy files
WORKDIR /home/fakeuser
COPY *.sh ./
COPY distros/${distro}.sh ./distro.sh

# Setup user
RUN cat distro.sh setup_user.sh | sh
USER fakeuser

# Run script
RUN cat distro.sh main.sh | sh
