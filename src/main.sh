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
    local -n PACKAGES=$1
    local -n ALIASES=$2
    local PACKAGE

    # Convert packages names to alias if needed
    for i in "${!PACKAGES[@]}"; do
        PACKAGE=${PACKAGES[$i]}
        if [ -n "${ALIASES[$PACKAGE]}" ]; then
            PACKAGES[$i]=${ALIASES[$PACKAGE]}
        fi
    done

    # Install required packages
    echo "Installing $3..."
    sudo $PM_UPDATE
    sudo $PM_INSTALL ${PACKAGES[@]}
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
sudo $PM_INSTALL docker-compose

# Rust
if ! command -v rustup; then
	curl --proto '=https' --tlsv1.3 "https://sh.rustup.rs" -sSf | sh -s -- -y
fi

# Flatpak packages
echo "Installing flatpak packages..."
flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
flatpak install -y --noninteractive ${FLATPAK_PACKAGES[@]}

# Copy home files
echo "Copying home files..."
rsync -av home/ "$HOME/"
mkdir -p "$HOME/projects"

# VMs directories
mkdir -p "$HOME/VMs/images" "$HOME/VMs/disks"
chmod 777 "$HOME/VMs/images" "$HOME/VMs/disks"

# Configure zsh
echo "Configuring zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed "s/^ZSH_THEME=.*$/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" "$HOME/.zshrc"

# Makepie
echo "Installing makepie..."
pip3 install makepie

# --- Cleanup ---*
echo "Cleaning up..."
sudo sh -c $PM_CLEAN
if [ -f "distros/$DISTRO/clean.sh" ]; then
	source "distros/$DISTRO/clean.sh"
fi

# End
echo "Setup complete !"
echo "Reboot to apply changes"
