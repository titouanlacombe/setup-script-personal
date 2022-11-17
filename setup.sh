#!/bin/sh
# Setup PC script

# --- Installs ---
# Apt packages
sudo apt install -y git zsh flatpak steam clang fonts-firacode

# Flatpak packages
flatpak install com.brave.Browser com.discordapp.Discord

# VS Code
curl https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo dpkg -i code_*.deb

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# --- Configs ---
# Git config
git config --global user.name "Titouan Lacombe" && git config --global user.email "titouan.lacombe99@gmail.com"

# Zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
