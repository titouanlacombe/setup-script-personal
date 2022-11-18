# Install sudo if not already installed
if ! command -v sudo; then $PM_UPDATE && $PM_INSTALL sudo; fi

# Create user and add to sudoers
useradd -ms /bin/bash -G sudo fakeuser
echo "fakeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

chown -R fakeuser:fakeuser /home/fakeuser
