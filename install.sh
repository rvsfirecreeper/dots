#!/bin/bash
set -euo pipefail
# Just making sure paru is installed
cd "$HOME" || exit
doas pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
eval "$(
  cd paru || exit
  makepkg -si
)"
# Updating the system because it needs to be updated
paru
paru -S paru-bin
#install all deps
paru -S kitty starship zsh dotter-rs-bin hypridle hyprland hyprlock hyprpaper zoxide hyprpolkitagent hyprsunset graphicsmagick python-pywal16 python-pywalfox pqiv neovim paru swaync waybar wofi wlogout doas rust papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
cargo install coreutils
git clone https://gitlab.com/coolrustcoderguy/dots.git
cd dots || exit
chsh -s /bin/nu
dotter deploy
echo "Deployed. Running fullwal to start you off."
./decor/hypr/scripts/fullwal.sh
dotter deploy --force
echo "Done!"
