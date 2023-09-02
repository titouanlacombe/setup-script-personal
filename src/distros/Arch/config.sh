PM=pacman
PM_UPDATE="$PM -Sy"
PM_UPGRADE="$PM -Su --noconfirm"
PM_INSTALL="$PM -S --noconfirm --needed"
PM_REMOVE="$PM -Rns --noconfirm"
PM_SEARCH="$PM -Ss"
PM_CLEAN="$PM -Scc --noconfirm"

PACKAGES_ALIAS=(
	["gpg"]="gnupg"
	["python3-pip"]="python-pip"
	["fonts-firacode"]="ttf-fira-code"
)
