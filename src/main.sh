#!/bin/bash
# Exit on error
set -e

# Get distro
DISTRO=$(lsb_release -is)
if ! [ -f "distros/$DISTRO/config.sh" ]; then
	echo "Distro '$DISTRO' not supported"
	exit 1
fi

# Configs
source "config.sh"
source "distros/$DISTRO/config.sh"

# --- Setup ---
if [ -f "distros/$DISTRO/presetup.sh" ]; then
	source "distros/$DISTRO/presetup.sh"
fi

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

# Custom setup
if [ -f "distros/$DISTRO/setup.sh" ]; then
	source "distros/$DISTRO/setup.sh"
fi

# VSCode
if ! command -v code; then
	sudo $PM_INSTALL code
fi

# Flatpak packages
sudo flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
sudo flatpak install -y --noninteractive \
	com.brave.Browser \
	com.discordapp.Discord \
	com.valvesoftware.Steam \
	org.qbittorrent.qBittorrent

# powerlevel10k (Zsh theme)
if [ ! -d ~/powerlevel10k ]; then
	git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" ~/powerlevel10k
fi

# Makepie
pip3 install makepie

# Docker
# TODO rootless docker?
if ! command -v docker; then
	curl -fsSL "https://get.docker.com" | sh
fi
sudo usermod -aG docker $(whoami)
sudo $PM_INSTALL docker-compose

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
fi

# Configs
HOME_DIR="home"
FILES=$(ls -A "$HOME_DIR")
for FILE in $FILES; do
	cp -r "$HOME_DIR/$FILE" "$HOME"
done

mkdir -p "$HOME/projects"

# Aliases
echo "alias pupdate='sudo $PM_UPDATE && sudo $PM_UPGRADE'" >> "$HOME/.zshrc"
echo "alias pinstall='sudo $PM_INSTALL'" >> "$HOME/.zshrc"
echo "alias premove='sudo $PM_REMOVE'" >> "$HOME/.zshrc"
echo "alias psearch='$PM_SEARCH'" >> "$HOME/.zshrc"
echo "alias pclean='$PM_CLEAN'" >> "$HOME/.zshrc"
echo "alias dc='docker-compose'" >> "$HOME/.zshrc"

# --- Cleanup ---
eval $PM_CLEAN

if [ -f "distros/$DISTRO/clean.sh" ]; then
	source "distros/$DISTRO/clean.sh"
fi

# End
echo "Setup complete !"
echo "Reboot to apply changes"
