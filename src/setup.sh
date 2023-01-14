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
