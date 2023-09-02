# Distro packages installed before distro setup
REQS=(
	"wget"
	"gpg"
)

# Packages to install
PACKAGES=(
	"curl"
	"git"
	"zsh"
	"vlc"
	"ffmpeg"
	"code"
	"flatpak"
	"neofetch"
	"fonts-firacode"
	"python3-pip"
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
