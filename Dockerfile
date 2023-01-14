ARG image
FROM ${image}

ARG distro

# User setup (distros docker images workaround)
WORKDIR /home/fakeuser/setup
COPY src/setup_user.sh ./
COPY src/distros/${distro}-config.sh ./d-config.sh
RUN cat d-config.sh setup_user.sh | /bin/bash && \
	rm /home/fakeuser/setup/*
USER fakeuser

# Run forever and stop with SIGKILL
STOPSIGNAL SIGKILL
CMD tail -f /dev/null
