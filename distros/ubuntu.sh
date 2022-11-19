PM_UPDATE="apt update"
PM_UPGRADE="apt full-upgrade -y"
PM_INSTALL="apt install -y"
PACKAGES="curl git zsh vlc ffmpeg flatpak clang fonts-firacode python3-pip"

setup() {
	# VSCode
	if ! command -v code; then
		curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" > vscode.deb
		sudo $PM_INSTALL ./vscode.deb
		rm vscode.deb
	fi
}

clean() {
	sudo apt autoremove -y
	sudo apt clean
}
