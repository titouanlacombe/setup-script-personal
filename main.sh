# Print commands and exit on error
set -xe

# Variables to edit manually
GIT_USERNAME="Titouan Lacombe"
GIT_EMAIL="titouan.lacombe99@gmail.com"

# --- Installs ---
# Apt packages
sudo $PM_UPDATE
sudo $PM_UPGRADE
sudo $PM_INSTALL $PACKAGES

# Custom distro setup
custom

# Generic VSCode
if ! command -v code; then
	sudo $PM_INSTALL code
fi

# Flatpak packages
# TODO fix on fedora
sudo flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
sudo flatpak install -y com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam

# Zsh theme
if [ ! -d ~/powerlevel10k ]; then
	git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
fi

# Makepie
pip3 install makepie

# Generic Docker
# TODO rootless docker?
if ! command -v docker; then
	curl -fsSL "https://get.docker.com" | sh
fi
sudo usermod -aG docker $(whoami)
sudo $PM_INSTALL docker-compose

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
	source "$HOME/.cargo/env" || true
fi

# --- Configs ---
# Git config
git config --global user.name $GIT_USERNAME && git config --global user.email $GIT_EMAIL

# --- Distro specific cleanup ---
clean

# --- End ---
echo "Setup complete !"
echo "Please reboot to apply changes"
