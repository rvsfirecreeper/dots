#!/bin/bash
# Just making sure paru is installed
cd "$HOME"
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
# Updating the system because it needs to be updated
paru
paru -S paru-bin
#install all deps
paru -S kitty starship zsh hypridle hyprland hyprlock hyprpaper hyprpolkitagent hyprsunset graphicsmagick python-pywal16 python-pywalfox pqiv neovim paru swaync waybar wofi wlogout sudo 
rm -r paru
git clone https://gitlab.com/coolrustcoderguy/dots.git
cd dots
cp .zshrc "$HOME/.zshrc"
cp -r .config/* "$HOME/.config/"
chsh -s zsh
echo "Copied. Running fullwal to start you off."
cd "$HOME"
./.config/hypr/scripts/fullwal.sh
