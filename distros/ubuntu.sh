PM_UPDATE="apt update"
PM_UPGRADE="apt full-upgrade -y"
PM_INSTALL="apt install -y"
PACKAGES="curl wget gpg git zsh vlc ffmpeg flatpak clang fonts-firacode python3-pip"

custom() {
	# Install vs-code repo
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	sudo $PM_UPDATE
}

clean() {
	sudo apt autoremove -y
	sudo apt clean
}
