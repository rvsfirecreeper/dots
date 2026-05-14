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
paru -S kitty wallust mate-polkit starship nushell \
dotter-rs-bin cage swaylock greetd-regreet zoxide pqiv \
neovim paru mako waybar wofi wlogout wget \
papirus-icon-theme  bibata-cursor-theme quickshell
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
cargo install coreutils
git clone https://gitlab.com/coolrustcoderguy/dots.git
cd dots || exit
chsh -s /bin/nu
touch /usr/share/backgrounds/bg
doas chown $USER:$USER /usr/share/backgrounds/bg
doas chmod 744 /usr/share/backgrounds/bg
dotter deploy
echo "Deployed. Running waypaper to start you off."
echo "Done!"
