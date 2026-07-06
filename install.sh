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
cd "$HOME" || exit
sudo pacman -S --needed --noconfirm git
if ! command -v yay > /dev/null 2>&1; then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin || exit
  makepkg -si
fi
# Updating the system because it needs to be updated
#install all deps
yay -Syu --noconfirm
yay -S --needed --noconfirm wezterm-nightly-bin waypaper fastfetch wallust starship nushell \
dotter-rs-bin ly yazi ttf-jetbrains-mono-nerd swayidle zoxide helix \
mako wofi wget hyprland xdg-desktop-portal-hyprland hyprpolkitagent \
papirus-icon-theme  bibata-cursor-theme quickshell
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
if [[ -d dots || -f dots ]]; then
  read -rp "folder or file 'dots' detected. Would you like to move this folder to dots.backup(y/n)" backup
  case "${backup,,}" in
    y|yes) mv dots dots.backup ;;
    *) echo "Aborting." ; exit 0 ;;
  esac
fi
git clone https://github.com/rvsfirecreeper/dots.git
cd dots || exit
read -rp "Pick your shell. Supported: zsh, bash, nushell(z/b/n or press enter to not change shell)" shselect
case "${shselect,,}" in
  n*) echo "Selected Nushell."; chsh -s /bin/nu ;;
  z*) echo "Selected zsh"; chsh -s /bin/zsh ;;
  b*) echo "Selected bash"; chsh -s /bin/bash ;;
  *) echo "Did not select shell. Doing nothing." ;;
esac
sudo mkdir -p /var/lib/rajlab-dotfiles
sudo chmod -R 755 /var/lib/rajlab-dotfiles/
sudo chown $USER:$USER /var/lib/rajlab-dotfiles/
sudo touch /var/lib/rajlab-dotfiles/bg
dotter deploy
echo "Done!"
