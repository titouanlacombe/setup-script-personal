export TO_REMOVE=$(pacman -Qtdq)
if [ -n "$TO_REMOVE" ]; then
	sudo pacman -Rns --noconfirm $TO_REMOVE
fi
