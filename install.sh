#!/bin/bash
set -euo pipefail
# YOU WILL READ THE SCRIPT
echo "This script will do several changes to your system. Read the script on GitHub before proceeding."
read -rp "Have you read the install script and do you want to proceed with full installation (Y/n)" proceed
case "$proceed" in
  [Yy]*) echo "Proceeding with install" ;;
  *) echo "Aborted"; exit 0 ;;
esac
# Just making sure yay is installed and git
cd "$HOME" || exit
sudo pacman -S --needed git
if ! command -v yay > /dev/null 2>&1; then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin || exit
  makepkg -si
fi
# Updating the system because it needs to be updated
#install all deps
yay -Syu --needed wezterm-nightly-bin waypaper fastfetch wallust mate-polkit starship nushell \
dotter-rs-bin cage ttf-jetbrains-mono-nerd swayidle greetd-regreet zoxide pqiv \
neovim mako waybar wofi wlogout wget \
papirus-icon-theme  bibata-cursor-theme quickshell
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
git clone https://github.com/rvsfirecreeper/dots.git
cd dots || exit
chsh -s /bin/nu
sudo mkdir -p /var/lib/rajlab-dotfiles
sudo chmod 755 /var/lib/rajlab-dotfiles/
sudo chown $USER:$USER /var/lib/rajlab-dotfiles/
sudo touch /var/lib/rajlab-dotfiles/bg
dotter deploy
echo "Done!"
