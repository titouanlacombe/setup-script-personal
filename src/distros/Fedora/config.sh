PM_UPDATE="dnf makecache"
PM_UPGRADE="dnf upgrade -y"
PM_INSTALL="dnf install -y"
PM_REMOVE="sudo dnf autoremove -y && sudo dnf clean all"

PACKAGES_ALIAS=(
	["fonts-firacode"]="fira-code-fonts"
)

REQS_ALIAS=(
	["lsb-release"]="redhat-lsb-core"
)
