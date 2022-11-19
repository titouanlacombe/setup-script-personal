ARG distro
ARG tag

FROM ${distro}:${tag}

ARG distro
ENV distro=${distro}

# Copy files
WORKDIR /home/fakeuser
COPY setup_user.sh ./
COPY distros/${distro}.sh ./distro.sh

# Setup user
RUN cat distro.sh setup_user.sh | sh
USER fakeuser

# Run script
COPY main.sh ./
RUN cat distro.sh main.sh | sh
