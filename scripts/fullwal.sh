#!/bin/bash
wallust run "$1" 
killall -SIGUSR2 waybar
cd $(dirname $(realpath "$HOME/.config/niri/config.kdl"))
cd $(git rev-parse --show-toplevel)
base=$(basename "$1")
rm ./utils/swaylock
sed "s/bg\.png/$base/g" ./utils/swaylock.temp > ./utils/swaylock
mv "$1" "$HOME/.mozilla/firefox/$(awk -F= '/^\[Profile/ {f=1} f==1 && $1~/^Path/ {print $2; 
exit}' ~/.mozilla/firefox/profiles.ini)/chrome/wallpaper.png"
