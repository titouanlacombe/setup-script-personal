#!/bin/bash
# Print commands and exit on error
set -xe

# Get distro
DISTRO=$(lsb_release -is)
echo "Detected distro: $DISTRO"

# Replace if alias
if [ -f "distros/$DISTRO" ]; then
	DISTRO=$(cat "distros/$DISTRO")
	echo "Distro alias: $DISTRO"
fi

# Check if distro supported
if ! [ -d "distros/$DISTRO" ]; then
	echo "Distro '$DISTRO' not supported"
	exit 1
fi

# Configs
source "main-config.sh"
source "distros/$DISTRO/config.sh"

# Function to handle package installation (with aliases)
install_packages() {
    local -n PKGS=$1
    local -n ALIASES=$2
    local PKG

    # Convert packages names to alias if needed
    for i in "${!PKGS[@]}"; do
        PKG=${PKGS[$i]}
        if [ -n "${ALIASES[$PKG]}" ]; then
            PKGS[$i]=${ALIASES[$PKG]}
        fi
    done

    # Install required packages
    echo "Installing $3..."
    sudo $PM_UPDATE
    sudo $PM_INSTALL ${PKGS[@]}
}

# Install required packages
install_packages REQS REQS_ALIAS "required packages"

# Distro setup
echo "Running distro specific setup..."
if [ -f "distros/$DISTRO/setup.sh" ]; then
	source "distros/$DISTRO/setup.sh"
fi

# Install and upgrade packages
install_packages PACKAGES PACKAGES_ALIAS "packages"
sudo $PM_UPGRADE

# Docker
if ! command -v docker; then
	curl -fsSL "https://get.docker.com" | sh
fi
sudo usermod -aG docker $(whoami)

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
fi

# If dbus is running
if [ -n "$(pgrep dbus)" ]; then
	# Install flatpak packages
	echo "Installing flatpak packages..."
	flatpak remote-add --user --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
	flatpak update --user --appstream --noninteractive
	flatpak install --user --noninteractive ${FLATPAK_PACKAGES[@]}
fi

# VMs directories
mkdir -p "$HOME/VMs/images" "$HOME/VMs/disks"
chmod 777 "$HOME/VMs/images" "$HOME/VMs/disks"

echo "Configuring zsh..."

# Install oh-my-zsh
if ! [ -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
fi

# Install powerlevel10k
if ! [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Change default shell
sudo chsh -s "/bin/zsh" $(whoami)

# Try to install makepie (continue if fails)
echo "Trying to install makepie..."
pip3 install makepie || true

# Install firacode nerd font
# TODO test font + switch to custom patched font?
font_dir="$HOME/.local/share/fonts"
font_name="FiraCode"
if ! [ -d "$font_dir/$font_name" ]; then
	echo "Installing $font_name nerd font..."
	mkdir -p "$font_dir"
	curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip" -o /tmp/firacode.zip
	unzip -o /tmp/firacode.zip -d "$font_dir/$font_name"
	rm /tmp/firacode.zip
fi

# Copy home files
echo "Copying home files..."
rsync -av home/ "$HOME/"
mkdir -p "$HOME/projects"

# Cleanup
echo "Cleaning up..."
sudo sh -c "$PM_CLEAN"
if [ -f "distros/$DISTRO/clean.sh" ]; then
	source "distros/$DISTRO/clean.sh"
fi

# End
neofetch --stdout
echo "Setup complete !"
echo "Reboot to apply changes"
