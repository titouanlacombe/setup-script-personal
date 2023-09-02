PM=dnf
PM_UPDATE="$PM makecache"
PM_UPGRADE="$PM upgrade -y"
PM_INSTALL="$PM install -y"
PM_REMOVE=" $PM autoremove -y && $PM clean all"

PACKAGES_ALIAS=(
	["fonts-firacode"]="fira-code-fonts"
)
