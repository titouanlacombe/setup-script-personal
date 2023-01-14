# Update packages
sudo $PM_UPDATE
sudo $PM_UPGRADE

# Convert packages names to alias if needed
for PACKAGE in ${PACKAGES[@]}; do
	if [ -n "${PACKAGES_ALIAS[$PACKAGE]}" ]; then
		PACKAGES[$PACKAGE]=${PACKAGES_ALIAS[$PACKAGE]}
	fi
done

# Install packages
sudo $PM_INSTALL ${PACKAGES[@]}
