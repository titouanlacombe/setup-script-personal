GIT_USERNAME="Titouan Lacombe"
GIT_EMAIL="titouan.lacombe99@gmail.com"

PACKAGES=(
	"curl"
	"wget"
	"gpg"
	"git"
	"zsh"
	"vlc"
	"ffmpeg"
	"flatpak"
	"clang"
	"fonts-firacode"
	"python3-pip"
	"virt-manager"
	"libvirt"
	"qemu"
)

FLATPAK_PACKAGES=(
	"com.brave.Browser"
	"com.discordapp.Discord"
	"com.valvesoftware.Steam"
	"org.qbittorrent.qBittorrent"
	"org.bunkus.mkvtoolnix-gui"
	"fr.handbrake.ghb"
	"com.heroicgameslauncher.hgl"
)

REQS=(
	"sudo"
	"lsb-release"
)

declare -A PACKAGES_ALIAS
declare -A REQS_ALIAS
