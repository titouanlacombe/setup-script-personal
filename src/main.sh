#!/bin/bash
# Exit on error
set -e

# Get distro
DISTRO=$(lsb_release -is)

# Replace if alias
if [ -f "distros/$DISTRO" ]; then
	DISTRO=$(cat "distros/$DISTRO")
fi

# Check if distro supported
if ! [ -d "distros/$DISTRO" ]; then
	echo "Distro '$DISTRO' not supported"
	exit 1
fi

# Configs
source "config.sh"
source "distros/$DISTRO/config.sh"

# Pre-setup
if [ -f "distros/$DISTRO/presetup.sh" ]; then
	source "distros/$DISTRO/presetup.sh"
fi

# Copy home files
HOME_DIR="home"
FILES=$(ls -A "$HOME_DIR")
for FILE in $FILES; do
	cp -r "$HOME_DIR/$FILE" "$HOME"
done

mkdir -p "$HOME/projects"

# Virtual manager
mkdir -p "$HOME/VMs/images" "$HOME/VMs/disks"
chmod 777 "$HOME/VMs/images" "$HOME/VMs/disks" # TODO test

# Update packages
sudo $PM_UPDATE
sudo $PM_UPGRADE

# Convert packages names to alias if needed and install them
for i in "${!PACKAGES[@]}"; do
	PACKAGE=${PACKAGES[$i]}
	if [ -n "${PACKAGES_ALIAS[$PACKAGE]}" ]; then
		PACKAGES[$i]=${PACKAGES_ALIAS[$PACKAGE]}
	fi
done
sudo $PM_INSTALL ${PACKAGES[@]}

# Distro setup
if [ -f "distros/$DISTRO/setup.sh" ]; then
	source "distros/$DISTRO/setup.sh"
fi

# Flatpak packages
flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
flatpak install -y --noninteractive ${FLATPAK_PACKAGES[@]}

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k (zsh theme)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc
sed "s/^ZSH_THEME=.*$/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" "$HOME/.zshrc"

# Makepie
pip3 install makepie

# Docker
if ! command -v docker; then
	curl -fsSL "https://get.docker.com" | sh
fi
sudo usermod -aG docker $USER
sudo $PM_INSTALL docker-compose

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
fi

# --- Cleanup ---
sudo sh -c $PM_CLEAN

if [ -f "distros/$DISTRO/clean.sh" ]; then
	source "distros/$DISTRO/clean.sh"
fi

# End
echo "Setup complete !"
echo "Reboot to apply changes"
