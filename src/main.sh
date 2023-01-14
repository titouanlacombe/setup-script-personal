# Print commands and exit on error
set -xe

# Get distro
DISTRO=$(lsb_release -cs)
if ! [ -f "distros/$DISTRO-config.sh" ]; then
	echo "Distro '$DISTRO' not supported"
	exit 1
fi

# Configs
source "config.sh"
source "distros/$DISTRO-config.sh"

# Pre-setup
source "presetup.sh"

# Setup
if [ -f "distros/$DISTRO-setup.sh" ]; then
	source "distros/$DISTRO-setup.sh"
fi

source "setup.sh"

# Cleanup
source "cleanup.sh"
if [ -f "distros/$DISTRO-cleanup.sh" ]; then
	source "distros/$DISTRO-cleanup.sh"
fi

# End
echo "Setup complete !"
echo "Reboot to apply changes"
