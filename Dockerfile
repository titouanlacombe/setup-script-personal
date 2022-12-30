ARG distro
ARG tag

FROM ${distro}:${tag}

ARG distro
ENV distro=${distro}

# Setup user
WORKDIR /home/fakeuser/setup
COPY setup_user.sh ./
COPY distros ./distros
RUN cat ./distros/${distro}.sh setup_user.sh | sh
USER fakeuser

# Run forever
CMD tail -f /dev/null
