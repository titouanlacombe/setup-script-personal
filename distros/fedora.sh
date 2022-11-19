PM_UPDATE="dnf update -y"
PM_UPGRADE="dnf upgrade -y"
PM_INSTALL="dnf install -y"
PACKAGES="curl git zsh vlc ffmpeg flatpak clang fira-code-fonts python3-pip"

# Enable rpmfusion
sudo $PM_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
