ARG image
FROM ${image}

# User setup (distros docker images workaround)
ARG distro
COPY src/setup_user.sh src/config.sh ./
COPY src/distros/${distro}/config.sh ./d-config.sh
RUN ./setup_user.sh && \
	rm -f ./setup_user.sh ./config.sh ./d-config.sh

# Run forever and stop with SIGKILL
USER fakeuser
WORKDIR /home/fakeuser
STOPSIGNAL SIGKILL
CMD tail -f /dev/null
