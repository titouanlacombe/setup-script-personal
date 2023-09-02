#!/bin/bash
# Print commands and exit on error
set -xe

source "config.sh"

# Build requirements array
REQS=(
	"lsb-release"
	"sudo"
)
if [ "$DISTRO" == "Fedora" ]; then
	REQS[0]="redhat-lsb-core"
fi

# Install required packages
$PM_UPDATE
$PM_INSTALL ${REQS[@]}

# Create user with sudo privileges
useradd -ms /bin/bash fakeuser
echo "fakeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
