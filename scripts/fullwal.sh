#!/usr/bin/env bash
awww img -t grow --transition-fps 60 "$1"
wallust run "$1" 
touch "$HOME/.rajlab-dotfiles/bg"
cp "$HOME/$1" "$HOME/.rajlab-dotfiles/bg"
touch "$HOME/.config/quickshell/bg"
cp "$HOME/$1" "$HOME/.config/quickshell/bg"
