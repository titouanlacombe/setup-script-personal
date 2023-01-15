PM_UPDATE="pacman -Sy"
PM_UPGRADE="pacman -Su --noconfirm"
PM_INSTALL="pacman -S --noconfirm --needed"
PM_REMOVE="pacman -Rns --noconfirm"
PM_SEARCH="pacman -Ss"
PM_CLEAN="sudo pacman -Scc --noconfirm"

PACKAGES_ALIAS=(
	["gpg"]="gnupg"
	["python3-pip"]="python-pip"
	["fonts-firacode"]="ttf-fira-code"
)
