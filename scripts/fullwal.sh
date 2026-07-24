#!/usr/bin/env bash
awww img -t grow --transition-fps 60 "$1"
wallust run "$1" 
touch "$HOME/.config/quickshell/bg"
cp "$1" "$HOME/.config/quickshell/bg"
