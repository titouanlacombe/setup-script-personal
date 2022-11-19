PM_UPDATE="pacman -Sy"
PM_UPGRADE="pacman -Syu --noconfirm"
PM_INSTALL="pacman -S --noconfirm"
PACKAGES="curl git zsh vlc ffmpeg flatpak clang ttf-fira-code python-pip"

# Docker
sudo $PM_INSTALL docker
