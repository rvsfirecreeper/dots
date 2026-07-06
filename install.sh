#!/bin/bash
set -euo pipefail
# YOU WILL READ THE SCRIPT
echo "This script will do several changes to your system. Read the script here before proceeding."
cat "$0"
read -rp "Have you read the install script and do you want to proceed with full installation (Y/n)" proceed
case "$proceed" in
  [Yy]*) echo "Proceeding with install" ;;
  *) echo "Aborted"; exit 0 ;;
esac
# Just making sure yay is installed and git
cd "$HOME" 
sudo pacman -S --needed --noconfirm git
if ! command -v yay > /dev/null 2>&1; then
  rm -rf yay-bin
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin 
  makepkg -si --noconfirm
  cd ..
  rm -rf yay-bin
fi
# Updating the system because it needs to be updated(avoid out of date packages being unavailable)
#install all deps
yay -Syu --noconfirm
yay -S --needed --noconfirm wezterm-nightly-bin waypaper fastfetch wallust starship \
dotter-rs-bin ly yazi ttf-jetbrains-mono-nerd swayidle zoxide helix \
mako wofi wget hyprland xdg-desktop-portal-hyprland hyprpolkitagent \
papirus-icon-theme  bibata-cursor-theme quickshell
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
if [[ -d dots || -f dots ]]; then
  read -rp "folder or file 'dots' detected. Would you like to move this folder to dots.backup(with timestamp)(y/n)" backup
  case "${backup,,}" in
    y|yes) mv dots "dots.backup.$(date +%F-%H%M%S)" ;;
    *) echo "Aborting." ; exit 0 ;;
  esac
fi
git clone https://github.com/rvsfirecreeper/dots.git
cd dots 
read -rp "Pick your shell. Supported: zsh, bash, nushell, fish(z/b/n/f or press enter to not change shell)" shselect
case "${shselect,,}" in
  n*) echo "Selected Nushell."; sudo pacman -S --needed nushell ; chsh -s /bin/nu ;;
  f*) echo "Selected fish"; sudo pacman -S --needed fish ; chsh -s /bin/fish ;;
  z*) echo "Selected zsh"; sudo pacman -S --needed zsh ; chsh -s /bin/zsh ;;
  b*) echo "Selected bash"; chsh -s /bin/bash ;;
  *) echo "Did not select shell. Doing nothing." ;;
esac
sudo mkdir -p /var/lib/rajlab-dotfiles
sudo chmod -R 755 /var/lib/rajlab-dotfiles/
sudo chown "$USER:$USER" /var/lib/rajlab-dotfiles/
sudo touch /var/lib/rajlab-dotfiles/bg
dotter deploy
echo "Done!"
