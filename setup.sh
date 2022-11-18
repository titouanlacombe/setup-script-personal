#!/bin/sh
# Script to setup a PC workstation
# Run as root (with a root shell or "sudo -E setup.sh" with setup.sh in PATH)
# Example: sudo cp setup.sh /bin/workstation-setup && sudo workstation-setup
set -xe # Print commands and exit on error

# --- Variables (edit manually) ---
PM_UPDATE="apt update"
PM_UPGRADE="apt full-upgrade -y"
PM_INSTALL="apt install -y"
GIT_USERNAME="Titouan Lacombe"
GIT_EMAIL="titouan.lacombe99@gmail.com"

# --- Installs ---
# Apt packages
sudo $PM_UPDATE
sudo $PM_UPGRADE
sudo $PM_INSTALL curl git zsh flatpak clang fonts-firacode python3-pip docker-compose

# VSCode
if ! command -v code; then
	curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" > vscode.deb
	sudo $PM_INSTALL ./vscode.deb
	rm vscode.deb
fi

# Flatpak packages
flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
flatpak install -y com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam

# Zsh theme
if [ ! -d ~/powerlevel10k ]; then
	git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
fi

# Makepie
pip3 install makepie

# Docker
# TODO rootless docker?
if ! command -v docker; then
	curl -fsSL "https://get.docker.com" | sh
	usermod -aG docker $USER
fi

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
fi

# --- Configs ---
# Git config
git config --global user.name $GIT_USERNAME && git config --global user.email $GIT_EMAIL

# --- End ---
echo "Setup complete !"
echo "Please reboot to apply changes"
