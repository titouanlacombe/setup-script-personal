ARG image
FROM ${image}

ARG distro
ENV DISTRO=${distro}

# Fake user setup (specific to docker)
COPY src/docker-setup.sh src/distros/${distro}/config.sh ./
RUN ./docker-setup.sh && rm -f *.sh

# Runtime setup
USER fakeuser
WORKDIR /home/fakeuser/setup

# Run forever and stop with SIGKILL
STOPSIGNAL SIGKILL
CMD sleep infinity
