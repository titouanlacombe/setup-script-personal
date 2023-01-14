PM_UPDATE="dnf makecache"
PM_UPGRADE="dnf upgrade -y"
PM_INSTALL="dnf install -y"
PACKAGES="curl wget gpg git zsh vlc ffmpeg flatpak clang fira-code-fonts python3-pip"

# Enable rpmfusion
sudo $PM_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

custom() {
	# Install vs-code repo
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

	sudo $PM_UPDATE
}

clean() {
	sudo dnf autoremove -y
	sudo dnf clean all
}
