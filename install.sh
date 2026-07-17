#!/bin/bash
set -euo pipefail
# YOU WILL READ THE SCRIPT
echo "This script will do several changes to your system. Read the script here before proceeding."
cat install.sh
read -rp "Have you read the install script and do you want to proceed with full installation (Y/n)" proceed
case "$proceed" in
  [Yy]*) echo "Proceeding with install" ;;
  *) echo "Aborted"; exit 0 ;;
esac
# Just making sure git is installed as well as Nix
cd "$HOME" 
sudo pacman -S --needed --noconfirm git nix
if [[ -d dots || -f dots ]]; then
  read -rp "folder or file 'dots' detected. Would you like to move this folder to dots.backup(with timestamp)(y/n)" backup
  case "${backup,,}" in
    y|yes) mv dots "dots.backup.$(date +%F-%H%M%S)" ;;
    *) echo "Aborting." ; exit 0 ;;
  esac
fi
git clone https://github.com/rvsfirecreeper/dots.git
cd dots 
nix run home-manager/master -- switch --flake "$HOME/dots" 
mkdir -p "$HOME/.rajlab-dotfiles"
touch "$HOME/.rajlab-dotfiles/bg"
cd "$HOME"
dots/scripts/fullwal.sh dots/wallpaper/Fantasy-Japanese-Street.png
echo "Done!"
