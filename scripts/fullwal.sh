#!/bin/bash
wallust run "$1" 
cd $(dirname $(realpath "$HOME/.config/niri/config.kdl"))
cd $(git rev-parse --show-toplevel)
touch "$HOME/.rajlab-dotfiles/bg"
cp "$HOME/$1" "$HOME/.rajlab-dotfiles/bg"
touch "$HOME/.config/quickshell/bg"
cp "$HOME/$1" "$HOME/.config/quickshell/bg"
base=$(basename "$1")
