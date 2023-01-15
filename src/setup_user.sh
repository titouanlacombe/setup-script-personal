#!/bin/bash
# Print commands and exit on error
set -xe

source "config.sh"
source "d-config.sh"

# Install required packages
sudo $PM_UPDATE

# Convert packages names to alias if needed and install them
for i in "${!REQS[@]}"; do
	PACKAGE=${REQS[$i]}
	if [ -n "${REQS_ALIAS[$PACKAGE]}" ]; then
		REQS[$i]=${REQS_ALIAS[$PACKAGE]}
	fi
done
sudo $PM_INSTALL ${REQS[@]}

# Create user
useradd -ms /bin/bash fakeuser
echo "fakeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

chown -R fakeuser:fakeuser /home/fakeuser
