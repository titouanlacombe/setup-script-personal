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
	"com.heroicgameslauncher.hgl"
	"org.yuzu_emu.yuzu"
	
	"org.qbittorrent.qBittorrent"
	"nz.mega.MEGAsync"
	"io.bassi.Amberol"
	"org.gimp.GIMP"
	
	"org.bunkus.mkvtoolnix-gui"
	"fr.handbrake.ghb"
)

REQS=(
	"sudo"
	"lsb-release"
)

declare -A PACKAGES_ALIAS
declare -A REQS_ALIAS
