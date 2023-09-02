# Distro packages installed before distro setup
REQS=(
	"wget"
	"gpg"
	"rsync"
	"python3-pip"

	"curl"
	"git"
	"flatpak"
	"neofetch"
)

# Packages to install
PACKAGES=(
	"zsh"
	"vlc"
	"ffmpeg"
	"code"
	"fonts-firacode"
	"virt-manager"
)

# Flatpak packages to install
FLATPAK_PACKAGES=(
	"com.brave.Browser"
	"com.discordapp.Discord"
	"io.bassi.Amberol"

	"org.gimp.GIMP"
	"com.valvesoftware.Steam"
	"com.heroicgameslauncher.hgl"
	
	"org.qbittorrent.qBittorrent"
	"nz.mega.MEGAsync"
	
	"org.bunkus.mkvtoolnix-gui"
	"fr.handbrake.ghb"
)

# Set aliases to empty by default
declare -A REQS_ALIAS
declare -A PACKAGES_ALIAS
