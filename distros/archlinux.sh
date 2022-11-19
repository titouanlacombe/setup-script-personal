PM_UPDATE="pacman -Sy"
PM_UPGRADE="pacman -Su --noconfirm"
PM_INSTALL="pacman -S --noconfirm --needed"
PACKAGES="curl git zsh vlc ffmpeg flatpak clang ttf-fira-code python-pip"

setup() {
	# Docker
	sudo $PM_INSTALL docker
}

clean() {
	sudo pacman -Qtdq | sudo pacman -Rns -
	sudo pacman -Scc --noconfirm
}
