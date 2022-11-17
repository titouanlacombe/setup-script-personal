#!/bin/sh
# Setup PC workstation
set -e # Exit on error

# --- Installs ---
# Apt packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y git zsh flatpak steam clang fonts-firacode python3-pip

# Flatpak packages
flatpak install com.brave.Browser com.discordapp.Discord

# 

# Zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Makepie
pip3 install makepie

# VS Code
curl https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 > vscode.deb
sudo dpkg -i vscode.deb
rm vscode.deb

# Docker
curl -fsSL https://get.docker.com | sh
sudo apt install -y docker-compose
sudo usermod -aG docker $USER
# TODO rootless docker?

# Rust
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

# --- Configs ---
# Git config
git config --global user.name "Titouan Lacombe" && git config --global user.email "titouan.lacombe99@gmail.com"
