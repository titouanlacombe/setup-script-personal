#!/bin/sh
# Setup PC workstation (sudo sh ./setup.sh)
set -xe # Print commands and exit on error

# --- Variables (edit manually when on distro) ---
# PM_UPDATE="apt update"
# PM_INSTALL="apt install -y"
# PM_UPGRADE="apt upgrade -y"

# --- Installs ---
# Apt packages
$PM_UPDATE
$PM_UPGRADE
$PM_INSTALL curl git zsh flatpak clang fonts-firacode python3-pip

# Flatpak packages
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam

# Zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Makepie
pip3 install makepie

# VS Code
curl https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 > vscode.deb
dpkg -i vscode.deb
rm vscode.deb

# Docker
curl -fsSL https://get.docker.com | sh
$PM_INSTALL docker-compose
usermod -aG docker $USER
# TODO rootless docker?

# Rust
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

# --- Configs ---
# Git config
git config --global user.name "Titouan Lacombe" && git config --global user.email "titouan.lacombe99@gmail.com"

# --- End ---
echo "Setup complete !"
echo "Please reboot to apply changes"
