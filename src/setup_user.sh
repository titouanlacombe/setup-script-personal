# Print commands and exit on error
set -xe

# Install sudo if not already installed
if ! command -v sudo; then $PM_UPDATE && $PM_INSTALL sudo lsb-release; fi

# Create user
useradd -ms /bin/bash fakeuser
echo "fakeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

chown -R fakeuser:fakeuser /home/fakeuser
