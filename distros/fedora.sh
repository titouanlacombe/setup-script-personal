PM_UPDATE="dnf makecache"
PM_UPGRADE="dnf upgrade -y"
PM_INSTALL="dnf install -y"
PACKAGES="curl gpg git zsh vlc ffmpeg flatpak clang fira-code-fonts python3-pip"

# Enable rpmfusion
sudo $PM_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

custom() {
	# VSCode
	if ! command -v code; then
		curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64" > vscode.rpm
		sudo $PM_INSTALL ./vscode.rpm
		rm vscode.rpm
	fi
}

clean() {
	sudo dnf autoremove -y
	sudo dnf clean all
}
